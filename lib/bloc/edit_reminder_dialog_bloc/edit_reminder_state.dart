part of 'edit_reminder_bloc.dart';

class EditReminderState extends Equatable {
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;

  factory EditReminderState.initialState() => EditReminderState(
        title: '',
        description: '',
        date: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        time: TimeOfDay.now(),
      );

  EditReminderState({
    @required this.title,
    @required this.description,
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
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
      );

  @override
  List<Object> get props => [
        title,
        description,
        date,
        time,
      ];
}
