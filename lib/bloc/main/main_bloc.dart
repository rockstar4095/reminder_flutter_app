import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_event.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:reminder_flutter_app/utils/notifications.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository repository;
  final Notifications notifications;

  MainBloc({
    this.repository,
    this.notifications,
  })  : assert(repository != null),
        assert(notifications != null),
        super(MainState.initialState()) {
    _loadReminders();
  }

  void _loadReminders() async {
    final reminders = await repository.getAllReminders();
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

      _resetNotifications(event.reminders);
    } else if (event is SaveReminderPressed) {
      _loadReminders();
    } else if (event is DeletePressed) {
      await _deleteReminders();
      _loadReminders();
      add(SelectModeDisabled());
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
    repository.deleteReminders(reminders);
    reminders.forEach((reminder) => notifications.cancelNotification(reminder));
  }

  /// resets notifications for all reminders which reminder DateTime is
  /// more than now.
  void _resetNotifications(List<Reminder> reminders) => reminders.forEach((e) {
        if (e.dateTime.isAfter(DateTime.now())) {
          notifications.saveNotification(e);
        }
      });
}
