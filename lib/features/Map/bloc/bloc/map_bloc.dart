import 'dart:io';
import 'dart:developer' as dev;

import 'package:alarm/alarm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:my_app/features/Map/services/gps_task_handler.dart';
import 'package:my_app/features/Map/services/rest_alarm.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<MapInitialized>(_onInitialized);
    on<MapTrackingToggled>(_onTrackingToggled);
    on<MapTaskDataReceived>(_onTaskDataReceived);
    on<MapRestAlarmDismissed>(_onRestAlarmDismissed);
    on<ClearErrorMessage>((event, emit) => emit(state.copyWith(errorMessage: '')));
    on<ClearRestAlarmEvent>((event, emit) => emit(state.copyWith(restAlarmElapsed: null)));
  }


  Future<void> _onInitialized(
    MapInitialized event,
    Emitter<MapState> emit,
  ) async {
    _initForegroundService();
    await _syncTrackingState(emit);
    await _determinePosition(emit);
  }

  void _initForegroundService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'gps_channel',
        channelName: 'GPS Tracking',
        channelDescription:
            'Theo dõi vị trí của bạn liên tục ngay cả khi ứng dụng ở chế độ nền',
        channelImportance: NotificationChannelImportance.MAX,
        priority: NotificationPriority.MAX,
        onlyAlertOnce: true,
        showWhen: true,
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  /// Đồng bộ trạng thái tracking nếu service đang chạy từ trước
  Future<void> _syncTrackingState(Emitter<MapState> emit) async {
    final isRunning = await FlutterForegroundTask.isRunningService;
    if (isRunning) {
      FlutterForegroundTask.addTaskDataCallback(_taskDataCallback);
      emit(state.copyWith(isTracking: true));
    }
  }


  // Lấy vị trí hiện tại
  Future<void> _determinePosition(Emitter<MapState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Vui lòng bật GPS/Wi-Fi để xác định vị trí.',
        ));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: 'Bạn cần cấp quyền truy cập vị trí.',
          ));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage:
              'Quyền vị trí bị từ chối vĩnh viễn. Vào cài đặt để bật lại.',
        ));
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      ).timeout(const Duration(seconds: 20));

      emit(state.copyWith(
        isLoading: false,
        center: LatLng(position.latitude, position.longitude),
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Không thể lấy vị trí: $e\nDùng vị trí mặc định (Hà Nội).',
      ));
    }
  }


  // Bật / tắt tracking
  Future<void> _onTrackingToggled(
    MapTrackingToggled event,
    Emitter<MapState> emit,
  ) async {
    // Quyền thông báo
    final notifPerm =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notifPerm != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }
      if (!await FlutterForegroundTask.canScheduleExactAlarms) {
        await FlutterForegroundTask.openAlarmsAndRemindersSettings();
      }
    }

    // Dừng service 
    if (await FlutterForegroundTask.isRunningService) {
      FlutterForegroundTask.removeTaskDataCallback(_taskDataCallback);
      await FlutterForegroundTask.stopService();
      emit(state.copyWith(isTracking: false));
      return;
    }

    // Bắt đầu service 
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      emit(state.copyWith(
        errorMessage: 'Cấp quyền vị trí "Khi dùng ứng dụng" để bắt đầu.',
      ));
      return;
    }

    if (permission != LocationPermission.always) {
      emit(state.copyWith(errorMessage: 'Cần quyển "Luôn luôn" để bắt đầu.'));
      return;
    }

    FlutterForegroundTask.addTaskDataCallback(_taskDataCallback);
    await FlutterForegroundTask.startService(
      notificationTitle: 'GPS Tracking',
      notificationText: 'Đang ghi lại hành trình của bạn',
      callback: startCallBack,
    );
    emit(state.copyWith(isTracking: true, errorMessage: ''));
  }

  // Nhận dữ liệu từ foreground task
  Future<void> _onTaskDataReceived(
    MapTaskDataReceived event,
    Emitter<MapState> emit,
  ) async {
    final type = event.data['type'] as String?;

    if (type == 'LOCATION_UPDATE') {
      final lat = event.data['latitude'] as double?;
      final lng = event.data['longitude'] as double?;
      if (lat != null && lng != null) {
        dev.log('>>> [Bloc] Nhận tọa độ mới: $lat, $lng');
        emit(state.copyWith(currentPosition: LatLng(lat, lng)));
      }
    } else if (type == 'REST_ALARM') {
      final elapsed = (event.data['elapsed'] as int?) ?? 0;
      dev.log('Nhận lệnh báo thức tại phút thứ: $elapsed');
      await RestAlarmService.setRestAlarm(
        delayMin: 0,
        elapsedMinutes: elapsed,
      );
      emit(state.copyWith(restAlarmElapsed: elapsed));
    }
  }


  // Stop alarm 
  void _onRestAlarmDismissed(
    MapRestAlarmDismissed event,
    Emitter<MapState> emit,
  ) {
    Alarm.stop(15);
    emit(state.copyWith(restAlarmElapsed: null));
  }

 
  void _taskDataCallback(Object data) {
    if (data is Map<String, dynamic>) {
      add(MapTaskDataReceived(data));
    }
  }

  @override
  Future<void> close() {
    FlutterForegroundTask.removeTaskDataCallback(_taskDataCallback);
    return super.close();
  }
}