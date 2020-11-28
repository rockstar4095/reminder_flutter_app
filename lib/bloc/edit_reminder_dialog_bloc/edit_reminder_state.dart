part of 'edit_reminder_bloc.dart';

class EditReminderState extends Equatable {
  final String title;
  final String description;
  final DateTime dateTime;

  EditReminderState({
    @required this.title,
    @required this.description,
    @required this.dateTime,
  });

  EditReminderState copyWith({
    String title,
    String description,
    DateTime dateTime,
  }) =>
      EditReminderState(
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
      );

  @override
  List<Object> get props => [
        title,
        description,
        dateTime,
      ];
}
