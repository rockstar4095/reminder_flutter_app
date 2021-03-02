part of 'edit_reminder_bloc.dart';

class EditReminderState extends Equatable {
  final String editedTitle;
  final String editedDescription;
  final DateTime date;
  final TimeOfDay time;
  final bool isShoppingReminder;
  final Set<Product> products;

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
        products: {},
      );

  EditReminderState({
    @required this.editedTitle,
    @required this.editedDescription,
    @required this.date,
    @required this.time,
    @required this.isShoppingReminder,
    @required this.products,
  });

  EditReminderState copyWith({
    String title,
    String description,
    DateTime date,
    TimeOfDay time,
    bool isShoppingReminder,
    Set<Product> products,
  }) =>
      EditReminderState(
        editedTitle: title ?? this.editedTitle,
        editedDescription: description ?? this.editedDescription,
        date: date ?? this.date,
        time: time ?? this.time,
        isShoppingReminder: isShoppingReminder ?? this.isShoppingReminder,
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [
        editedTitle,
        editedDescription,
        date,
        time,
        isShoppingReminder,
        products,
      ];
}
