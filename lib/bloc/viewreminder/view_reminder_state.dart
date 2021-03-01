part of 'view_reminder_bloc.dart';

class ViewReminderState extends Equatable {
  final Reminder reminder;

  ViewReminderState({
    this.reminder,
  });

  ViewReminderState copyWith({
    Reminder reminder,
  }) =>
      ViewReminderState(
        reminder: reminder ?? this.reminder,
      );

  @override
  List<Object> get props => [reminder];

  @override
  bool get stringify => true;
}
