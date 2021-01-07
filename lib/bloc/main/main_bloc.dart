import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_flutter_app/bloc/main/main_event.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository _repository;
  final notificationsPlugin = FlutterLocalNotificationsPlugin()
    ..initialize(InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
    ));

  MainBloc(this._repository) : super(MainState.initialState()) {
    _loadReminders();
  }

  void _loadReminders() async {
    final reminders = await _repository.getAllReminders();
    reminders.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : -1);
    add(RemindersLoaded(reminders: reminders));
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is ItemSelected) {
      yield state.copyWith(isSelectedModeActive: true);
    } else if (event is SelectModeDisabled) {
      yield state.copyWith(isSelectedModeActive: false);
    } else if (event is RemindersLoaded) {
      yield state.copyWith(
        reminders: event.reminders,
        wereTripsLoaded: true,
      );
    } else if (event is SaveReminderPressed) {
      _loadReminders();
    } else if (event is DeletePressed) {
      await _deleteReminders();
      _loadReminders();
      add(SelectModeDisabled());
    } else if (event is ReminderOpened) {
      _loadReminder(event.reminderId);
    } else if (event is OpenedReminderLoaded) {
      yield state.copyWith(
        openedTitle: event.openedTitle,
        openedDescription: event.openedDescription,
        openedDateTime: event.openedDateTime,
      );
    } else if (event is EditReminderDialogOpened) {
      yield* _disabledSelectMode();
    }
  }

  Stream<MainState> _disabledSelectMode() async* {
    final unselectedReminders = <Reminder>[];
    for (final reminder in state.reminders) {
      final unselectedReminder =
          reminder.isSelected ? reminder.copyWith(isSelected: false) : reminder;

      unselectedReminders.add(unselectedReminder);
    }
    yield state.copyWith(reminders: unselectedReminders);
    add(SelectModeDisabled());
  }

  Future<void> _loadReminder(int id) async {
    final reminder = await _getReminder(id);
    add(
      OpenedReminderLoaded(
        openedTitle: reminder.title,
        openedDescription: reminder.description,
        openedDateTime: reminder.dateTime,
      ),
    );
  }

  void onItemSelect(int reminderId) {
    final reminder =
        state.reminders.singleWhere((reminder) => reminder.id == reminderId);
    final reminderIndex = state.reminders.indexOf(reminder);
    state.reminders[reminderIndex] =
        reminder.copyWith(isSelected: !reminder.isSelected);

    add(ItemSelected());

    final selectedRemindersQuantity =
        state.reminders.where((reminder) => reminder.isSelected).length;
    if (selectedRemindersQuantity == 0) {
      add(SelectModeDisabled());
    }
  }

  Future<void> _deleteReminders() async {
    final reminders = state.reminders.where((it) => it.isSelected).toList();
    _repository.deleteReminders(reminders);
    reminders.forEach((it) => notificationsPlugin.cancel(it.id));
  }

  Future<Reminder> _getReminder(int id) => _repository.getReminder(id);
}
