part of 'view_reminder_bloc.dart';

class ViewReminderState extends Equatable {
  final String openedTitle;
  final String openedDescription;
  final DateTime openedDateTime;
  final bool openedIsShoppingReminder;

  ViewReminderState({
    this.openedTitle,
    this.openedDescription,
    this.openedDateTime,
    this.openedIsShoppingReminder,
  });

  ViewReminderState copyWith({
    String openedTitle,
    String openedDescription,
    DateTime openedDateTime,
    bool openedIsShoppingReminder,
  }) =>
      ViewReminderState(
        openedTitle: openedTitle ?? this.openedTitle,
        openedDescription: openedDescription ?? this.openedDescription,
        openedDateTime: openedDateTime ?? this.openedDateTime,
        openedIsShoppingReminder:
            openedIsShoppingReminder ?? this.openedIsShoppingReminder,
      );

  @override
  List<Object> get props => [
        openedTitle,
        openedDescription,
        openedDateTime,
        openedIsShoppingReminder,
      ];
}
