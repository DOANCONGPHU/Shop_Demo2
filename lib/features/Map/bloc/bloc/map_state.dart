part of 'map_bloc.dart';

class MapState {
  final bool isLoading;
  final bool isTracking;
  final LatLng center;
  final LatLng? currentPosition;
  final String errorMessage;

  
  final int? restAlarmElapsed;

  const MapState({
    this.isLoading = true,
    this.isTracking = false,
    this.center = const LatLng(21.0285, 105.8542),
    this.currentPosition,
    this.errorMessage = '',
    this.restAlarmElapsed,
  });

  MapState copyWith({
    bool? isLoading,
    bool? isTracking,
    LatLng? center,
    LatLng? currentPosition,
    String? errorMessage,
  
    Object? restAlarmElapsed = _sentinel,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      isTracking: isTracking ?? this.isTracking,
      center: center ?? this.center,
      currentPosition: currentPosition ?? this.currentPosition,
      errorMessage: errorMessage ?? this.errorMessage,
      restAlarmElapsed: restAlarmElapsed == _sentinel
          ? this.restAlarmElapsed
          : restAlarmElapsed as int?,
    );
  }
}


const Object _sentinel = Object();