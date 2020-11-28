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
