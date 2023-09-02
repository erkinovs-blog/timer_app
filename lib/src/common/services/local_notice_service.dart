import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class LocalNoticeService {
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> setup() async {
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const LinuxInitializationSettings linuxSettings =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    const initSettings =
        InitializationSettings(android: androidSetting, linux: linuxSettings);

    await _localNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }

  static Future<void> addNotification({
    required String title,
    required String body,
    required int endTime,
    required String channel,
  }) async {
    tz_data.initializeTimeZones();
    final scheduleTime =
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);

    final androidDetail = AndroidNotificationDetails(
      channel,
      channel,
      enableVibration: true,
      importance: Importance.max,
      fullScreenIntent: true,
      priority: Priority.max,
      autoCancel: true,
    );

    const iosDetail = DarwinNotificationDetails();

    LinuxNotificationDetails? linuxSettings = const LinuxNotificationDetails();

    final noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
      linux: linuxSettings,
    );

    const id = 0;

    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );

    // await _localNotificationsPlugin.show(
    //   0,
    //   "title",
    //   "body",
    //   noticeDetail,
    // );
  }
}
