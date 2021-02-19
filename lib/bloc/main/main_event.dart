import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reminder_flutter_app/model/reminder.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemSelected extends MainEvent {}

class SelectModeDisabled extends MainEvent {}

class RemindersLoaded extends MainEvent {
  final List<Reminder> reminders;

  RemindersLoaded({@required this.reminders});

  @override
  List<Object> get props => [reminders];
}

class DeletePressed extends MainEvent {}

class SaveReminderPressed extends MainEvent {}

class ReminderOpened extends MainEvent {
  final int reminderId;

  ReminderOpened({@required this.reminderId});

  @override
  List<Object> get props => [reminderId];
}

class OpenedReminderLoaded extends MainEvent {
  final String openedTitle;
  final String openedDescription;
  final DateTime openedDateTime;
  final bool openedIsShoppingReminder;

  OpenedReminderLoaded({
    @required this.openedTitle,
    @required this.openedDescription,
    @required this.openedDateTime,
    @required this.openedIsShoppingReminder,
  });

  @override
  List<Object> get props => [
        openedTitle,
        openedDescription,
        openedDateTime,
        openedIsShoppingReminder,
      ];
}

class EditReminderDialogOpened extends MainEvent {}
