part of 'map_bloc.dart';

abstract class MapEvent {}


class MapInitialized extends MapEvent {}


class MapTrackingToggled extends MapEvent {}


class MapTaskDataReceived extends MapEvent {
  final Map<String, dynamic> data;
  MapTaskDataReceived(this.data);
}

class ClearErrorMessage extends MapEvent {}

class MapRestAlarmDismissed extends MapEvent {}

class ClearRestAlarmEvent extends MapEvent {}