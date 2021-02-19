part of 'edit_reminder_bloc.dart';

class EditReminderState extends Equatable {
  final String editedTitle;
  final String editedDescription;
  final DateTime date;
  final TimeOfDay time;
  final bool isShoppingReminder;

  factory EditReminderState.initialState() => EditReminderState(
        editedTitle: '',
        editedDescription: '',
        date: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        time: TimeOfDay.now(),
        isShoppingReminder: false,
      );

  EditReminderState({
    @required this.editedTitle,
    @required this.editedDescription,
    @required this.date,
    @required this.time,
    @required this.isShoppingReminder,
  });

  EditReminderState copyWith({
    String title,
    String description,
    DateTime date,
    TimeOfDay time,
    bool isShoppingReminder,
  }) =>
      EditReminderState(
        editedTitle: title ?? this.editedTitle,
        editedDescription: description ?? this.editedDescription,
        date: date ?? this.date,
        time: time ?? this.time,
        isShoppingReminder: isShoppingReminder ?? this.isShoppingReminder,
      );

  @override
  List<Object> get props => [
        editedTitle,
        editedDescription,
        date,
        time,
        isShoppingReminder,
      ];
}
