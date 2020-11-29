import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_event.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository _repository;

  MainBloc(this._repository) : super(MainState.initialState()) {
    _loadReminders();
  }

  void _loadReminders() async {
    final reminders = await _repository.getAllReminders();
    reminders.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : -1);
    if (reminders.isNotEmpty) {
      add(RemindersLoaded(reminders: reminders));
    }
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is ItemSelected) {
      yield state.copyWith(isSelectedModeActive: true);
    } else if (event is SelectModeDisabled) {
      yield state.copyWith(isSelectedModeActive: false);
    } else if (event is RemindersLoaded) {
      yield state.copyWith(reminders: event.reminders);
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
    }
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

  Future<void> _deleteReminders() async => _repository.deleteReminders(
        state.reminders.where((reminder) => reminder.isSelected).toList(),
      );

  Future<Reminder> _getReminder(int id) => _repository.getReminder(id);
}
