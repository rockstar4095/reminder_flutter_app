part of 'edit_reminder_bloc.dart';

abstract class EditReminderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SavePressed extends EditReminderEvent {
  final Reminder reminder;

  SavePressed({@required this.reminder});

  @override
  List<Object> get props => [reminder];
}

class TitleChanged extends EditReminderEvent {
  final String title;

  TitleChanged({@required this.title});

  @override
  List<Object> get props => [title];
}

class DescriptionChanged extends EditReminderEvent {
  final String description;

  DescriptionChanged({@required this.description});

  @override
  List<Object> get props => [description];
}

class DateChanged extends EditReminderEvent {
  final DateTime date;

  DateChanged({@required this.date});

  @override
  List<Object> get props => [date];
}

class TimeChanged extends EditReminderEvent {
  final TimeOfDay time;

  TimeChanged({@required this.time});

  @override
  List<Object> get props => [time];
}

class ExistingReminderOpened extends EditReminderEvent {
  final Reminder reminder;

  ExistingReminderOpened({@required this.reminder});

  @override
  List<Object> get props => [reminder];
}

class ShoppingReminderSwitched extends EditReminderEvent {
  final bool isShoppingReminder;

  ShoppingReminderSwitched({
    @required this.isShoppingReminder,
  }) : assert(isShoppingReminder != null);

  @override
  List<Object> get props => [isShoppingReminder];
}
