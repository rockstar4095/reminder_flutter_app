part of 'edit_reminder_bloc.dart';

class EditReminderState extends Equatable {
  final String editedTitle;
  final String editedDescription;
  final DateTime date;
  final TimeOfDay time;

  factory EditReminderState.initialState() => EditReminderState(
        editedTitle: '',
        editedDescription: '',
        date: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        time: TimeOfDay.now(),
      );

  EditReminderState({
    @required this.editedTitle,
    @required this.editedDescription,
    @required this.date,
    @required this.time,
  });

  EditReminderState copyWith({
    String title,
    String description,
    DateTime date,
    TimeOfDay time,
  }) =>
      EditReminderState(
        editedTitle: title ?? this.editedTitle,
        editedDescription: description ?? this.editedDescription,
        date: date ?? this.date,
        time: time ?? this.time,
      );

  @override
  List<Object> get props => [
        editedTitle,
        editedDescription,
        date,
        time,
      ];
}
