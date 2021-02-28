part of 'view_reminder_bloc.dart';

abstract class ViewReminderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReminderLoaded extends ViewReminderEvent {
  final Reminder reminder;

  ReminderLoaded({@required this.reminder}) : assert(reminder != null);

  @override
  List<Object> get props => [reminder];
}

class ReminderOpened extends ViewReminderEvent {
  final int reminderId;

  ReminderOpened({@required this.reminderId});

  @override
  List<Object> get props => [reminderId];
}

class OpenedReminderLoaded extends ViewReminderEvent {
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
