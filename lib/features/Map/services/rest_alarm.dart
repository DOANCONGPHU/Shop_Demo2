import 'dart:ui';

import 'package:alarm/alarm.dart';

class RestAlarmService {
  static Future<void> setRestAlarm({
    required int delayMin,
    int? elapsedMinutes,
  }) async {
    final now = DateTime.now();
    final nextAlarmTime = now.add(Duration(minutes: delayMin));
    final displayMin = elapsedMinutes ?? 0;
    final alarmSettings = AlarmSettings(
      id: 15,
      dateTime: nextAlarmTime,
      assetAudioPath: 'assets/sounds/zalo.mp3',
      loopAudio: true,
      vibrate: true,
      volumeSettings: VolumeSettings.fade(
        volume: 0.5,
        fadeDuration: Duration(seconds: 5),
      ),
      notificationSettings: NotificationSettings(
        title: 'Nghỉ ngơi một chút',
        body:
            'Bạn đã di chuyển được $displayMin phút, hãy đứng dậy và đi lại để thư giãn nhé!',
        stopButton: 'Dừng',
        icon: 'notification_icon',
        iconColor: Color(0xff862778),
      ),
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }

  static Future<void> stopRestAlarm() async {
    await Alarm.stop(15);
  }
}
