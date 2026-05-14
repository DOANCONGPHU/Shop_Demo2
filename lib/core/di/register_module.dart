import 'package:injectable/injectable.dart';
import 'package:my_app/core/Notification/notification_service.dart';
import 'package:my_app/core/database/isar_service.dart';

@module
abstract class AppModule {
  @preResolve
  Future<NotificationService> get notificationService async {
    final service = NotificationService();
    await service.init(); 
    return service;
  }

  @preResolve

Future<IsarService> get isarService async {
  final instance = IsarService();
  await instance.init(); 
  return instance;
}

}