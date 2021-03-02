import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:timezone/data/latest_all.dart' as timeZone;
import 'package:timezone/timezone.dart' as timeZone;

abstract class Notifications {
  Future<void> saveNotification(Reminder reminder);

  void cancelNotification(Reminder reminder);
}

class NotificationsImpl implements Notifications {
  final notificationsPlugin = FlutterLocalNotificationsPlugin()
    ..initialize(InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
    ));

  @override
  void cancelNotification(Reminder reminder) =>
      notificationsPlugin.cancel(reminder.id);

  @override
  Future<void> saveNotification(Reminder reminder) async {
    await _initTimeZone();
    await notificationsPlugin.zonedSchedule(
      reminder.id ?? 999999,
      reminder.title,
      reminder.description,
      _scheduledDateTime(reminder),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          'your channel description',
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> _initTimeZone() async {
    final platform = MethodChannel('reminder_flutter_app');
    timeZone.initializeTimeZones();
    final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
    timeZone.setLocalLocation(timeZone.getLocation(timeZoneName));
  }

  timeZone.TZDateTime _scheduledDateTime(Reminder reminder) =>
      timeZone.TZDateTime.now(timeZone.local).add(_scheduleDuration(reminder));

  Duration _scheduleDuration(Reminder reminder) {
    final userSetDuration = reminder.dateTime.difference(DateTime.now());
    return userSetDuration.inMilliseconds > 0
        ? userSetDuration
        : Duration(milliseconds: 1000);
  }
}
