import 'dart:async';
import 'dart:io';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as developer;

@pragma('vm:entry-point')
void startCallBack() {
  FlutterForegroundTask.setTaskHandler(GpsTaskHandler());
}

class GpsTaskHandler extends TaskHandler {
  StreamSubscription<Position>? _positionStream;
  DateTime? _startTime;
  int _lastRestMinute = 0;
  final int restInterval = 60;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    developer.log('GPS Service Started');
    _startTime = timestamp;

    if (Platform.isIOS) {
      _positionStream =
          Geolocator.getPositionStream(
            locationSettings: AppleSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 10,
              showBackgroundLocationIndicator: true,
              allowBackgroundLocationUpdates: true,
            ),
          ).listen(
            _handlePositionUpdate,
            onError: (e) => developer.log('--- [iOS GPS LỖI]: $e ---'),
          );
    }
  }

  // Hàm này sẽ được gọi định kỳ theo khoảng thời gian đã thiết lập
  @override
  Future<void> onRepeatEvent(DateTime timestamp) async {
    if (Platform.isIOS) {
      return;
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).timeout(const Duration(seconds: 15));
      _handlePositionUpdate(position);
    } catch (e) {
      developer.log('--- [Android GPS LỖI]: $e ---');
    }
  }

  void _handlePositionUpdate(Position position) {
    final platform = Platform.isIOS ? 'iOS' : 'Android';
    developer.log('--- [$platform] Đã lấy tọa độ: ${position.latitude} ---');
    // Tính toán thời gian đã trôi qua kể từ khi bắt đầu hành trình
    final now = DateTime.now();

    final elapsedMinutes = _startTime != null
        ? now.difference(_startTime!).inMinutes
        : 0;
    developer.log('--- [$platform] Đã chạy: $elapsedMinutes phút ---');

    // Logic báo thức định kỳ
    if (elapsedMinutes > 0 &&
        elapsedMinutes % restInterval == 0 &&
        _lastRestMinute != elapsedMinutes) {
      _lastRestMinute = elapsedMinutes;
      _sendSafeData({'type': 'REST_ALARM', 'elapsed': elapsedMinutes});
      developer.log('--- [HỆ THỐNG]: Gửi lệnh hú còi nghỉ giải lao ---');
    }

    FlutterForegroundTask.updateService(
      notificationTitle: 'Vị trí hiện tại',
      notificationText:
          'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}',
    );

    final Map<String, dynamic> data = {
      'type': 'LOCATION_UPDATE',
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': DateTime.now().toIso8601String(),
    };
    _sendSafeData(data);
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    developer.log('GPS Service Destroyed (isTimeout: $isTimeout)');

    await _positionStream?.cancel();
    _positionStream = null;

    await Future.delayed(const Duration(milliseconds: 200));
  }

  void _sendSafeData(Map<String, dynamic> data) async {
    if (await FlutterForegroundTask.isRunningService) {
      FlutterForegroundTask.sendDataToMain(data);
    }
  }
}
