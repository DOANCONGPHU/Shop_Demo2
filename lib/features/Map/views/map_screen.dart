import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/features/Map/bloc/bloc/map_bloc.dart';
import 'package:app_settings/app_settings.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc()..add(MapInitialized()),
      child: const _MapView(),
    );
  }
}

class _MapView extends StatefulWidget {
  const _MapView();

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  GoogleMapController? _mapController;
  bool _isMapReady = false;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _isMapReady = true;

    final center = context.read<MapBloc>().state.center;
    const defaultCenter = LatLng(21.0285, 105.8542);
    if (center != defaultCenter) {
      _mapController?.animateCamera(CameraUpdate.newLatLng(center));
    }
  }

  void _animateTo(LatLng target) {
    if (_isMapReady) {
      _mapController?.animateCamera(CameraUpdate.newLatLng(target));
    }
  }

  // Hàm hiển thị dialog yêu cầu cấp quyền vị trí nền
  void _showBackgroundPermissionDialog() {
    showDialog(
      barrierColor: Colors.white.withValues(alpha: 0.8),
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.redAccent),
            SizedBox(width: 8),
            Text('Quyền vị trí nền'),
          ],
        ),
        content: const Text(
          'Ứng dụng cần quyền truy cập vị trí "Luôn luôn". '
          'Vào Cài đặt -> Ứng dụng → My App → Vị trí và chọn "Luôn luôn".\n\n'
          'Vui lòng bấm "MỞ CÀI ĐẶT" để cập nhật.',
          style: TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<MapBloc>().add(ClearErrorMessage());
            },

            child: const Text('ĐỂ SAU'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await AppSettings.openAppSettings(type: AppSettingsType.location);
            },
            child: const Text(
              'MỞ CÀI ĐẶT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Dialog nghỉ giải lao

  void _showRestAlarmDialog(int elapsed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (digalogContext) => AlertDialog.adaptive(
        title: const Row(
          children: [
            Icon(Icons.timer_outlined, color: Colors.orange),
            SizedBox(width: 10),
            Text('Nghỉ giải lao thôi!'),
          ],
        ),
        content: Text('Bạn đã di chuyển liên tục $elapsed phút rồi.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(digalogContext);
              context.read<MapBloc>().add(MapRestAlarmDismissed());
            },
            child: const Text('Đã nghỉ xong'),
          ),
        ],
      ),
    );
  }

  //Build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Google Map',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 70, 125, 203),
          ),
        ),
        shadowColor: Colors.black,
        elevation: 1,
      ),
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state.currentPosition != null) {
            _animateTo(state.currentPosition!);
          } else {
            _animateTo(state.center);
          }
          // Yêu cầu quyền nền
          if (state.errorMessage == 'Cần quyển "Luôn luôn" để bắt đầu.') { 
            _showBackgroundPermissionDialog();
            return;
          }

          // Snackbar lỗi
          if (state.errorMessage.isNotEmpty &&
              state.errorMessage != 'Cần quyển "Luôn luôn" để bắt đầu.') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }

          // Dialog nghỉ giải lao
          if (state.restAlarmElapsed != null) {
            _showRestAlarmDialog(state.restAlarmElapsed!);
            context.read<MapBloc>().add(ClearRestAlarmEvent());
          }
        },

        listenWhen: (prev, curr) =>
            prev.currentPosition != curr.currentPosition ||
            prev.errorMessage != curr.errorMessage ||
            prev.restAlarmElapsed != curr.restAlarmElapsed,

        // Builder: UI
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 65.0),
            child: Stack(
              children: [
                // Bản đồ
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: state.center,
                    zoom: 15.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                ),

                //Thanh tìm kiếm
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: SearchBar(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    onTap: () {},
                    onChanged: (_) {},
                    hintText: 'Tìm kiếm địa điểm',
                    leading: const Icon(Icons.search),
                  ),
                ),

                Positioned(
                  left: 16,
                  bottom: 18,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        context.read<MapBloc>().add(MapTrackingToggled()),
                    icon: Icon(
                      state.isTracking ? Icons.stop : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    label: Text(
                      state.isTracking ? 'Dừng theo dõi' : 'Bắt đầu hành trình',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.isTracking
                          ? Colors.red
                          : Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
