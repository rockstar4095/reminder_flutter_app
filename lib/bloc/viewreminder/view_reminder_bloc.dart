import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

part 'view_reminder_event.dart';
part 'view_reminder_state.dart';

class ViewReminderBloc extends Bloc<ViewReminderEvent, ViewReminderState> {
  final MainRepository _repository;

  ViewReminderBloc(this._repository)
      : super(ViewReminderState(
          openedTitle: '',
          openedDescription: '',
          openedIsShoppingReminder: false,
          openedDateTime: DateTime.now(),
        ));

  @override
  Stream<ViewReminderState> mapEventToState(ViewReminderEvent event) async* {
    if (event is ReminderLoaded) {
      yield ViewReminderState(
        openedTitle: event.reminder.title,
        openedDescription: event.reminder.description,
        openedDateTime: event.reminder.dateTime,
        openedIsShoppingReminder: event.reminder.isShoppingReminder,
      );
    } else if (event is ReminderOpened) {
      _loadReminder(event.reminderId);
    }
  }

  Future<void> _loadReminder(int id) async {
    final reminder = await _getReminder(id);
    add(ReminderLoaded(reminder: reminder));
  }

  Future<Reminder> _getReminder(int id) => _repository.getReminder(id);
}
