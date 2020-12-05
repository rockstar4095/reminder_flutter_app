import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_flutter_app/bloc/main/main_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_event.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:timezone/data/latest_all.dart' as timeZone;
import 'package:timezone/timezone.dart' as timeZone;

part 'edit_reminder_event.dart';
part 'edit_reminder_state.dart';

class EditReminderBloc extends Bloc<EditReminderEvent, EditReminderState> {
  final MainRepository _repository;
  final MainBloc _mainBloc;
  final int currentReminderId;
  String _title = '';
  String _description = '';
  String get title => _title;
  String get description => _description;

  EditReminderBloc(
    this._repository,
    this._mainBloc,
    this.currentReminderId,
  ) : super(EditReminderState.initialState()) {
    if (currentReminderId != null) {
      _openReminder(currentReminderId);
    }
  }

  @override
  Stream<EditReminderState> mapEventToState(EditReminderEvent event) async* {
    if (event is SavePressed) {
      final insertedReminder = _isReminderUpdate()
          ? await _updateReminder(event.reminder)
          : await _saveReminder(event.reminder);
      await _saveNotification(insertedReminder);
      _mainBloc.add(SaveReminderPressed());
    } else if (event is TitleChanged) {
      _title = event.title;
    } else if (event is DescriptionChanged) {
      _description = event.description;
    } else if (event is DateChanged) {
      yield state.copyWith(date: event.date);
    } else if (event is TimeChanged) {
      yield state.copyWith(time: event.time);
    } else if (event is ExistingReminderOpened) {
      final reminder = event.reminder;

      _title = reminder.title;
      _description = reminder.description;

      yield state.copyWith(
        title: reminder.title,
        description: reminder.description,
        date: _getReminderDate(reminder.dateTime),
        time: _getReminderTime(reminder.dateTime),
      );
    }
  }

  DateTime _getReminderDate(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  TimeOfDay _getReminderTime(DateTime dateTime) =>
      TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);

  Future<Reminder> _saveReminder(Reminder reminder) =>
      _repository.insertReminder(reminder);

  Future<Reminder> _updateReminder(Reminder reminder) =>
      _repository.updateReminder(reminder);

  Future<Reminder> _getReminder(int id) => _repository.getReminder(id);

  bool _isReminderUpdate() => currentReminderId != null;

  Future<void> _openReminder(int id) async =>
      add(ExistingReminderOpened(reminder: await _getReminder(id)));

  Future<void> _saveNotification(Reminder reminder) async {
    await _initTimeZone();
    await _mainBloc.notificationsPlugin.zonedSchedule(
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
