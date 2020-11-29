part of 'main_bloc.dart';

class MainState extends Equatable {
  final bool isSelectedModeActive;
  final List<Reminder> reminders;
  final int quantityOfSelectedItems;
  final String openedTitle;
  final String openedDescription;
  final DateTime openedDateTime;

  MainState({
    @required this.isSelectedModeActive,
    @required this.reminders,
    @required this.openedTitle,
    @required this.openedDescription,
    @required this.openedDateTime,
  }) : quantityOfSelectedItems =
            reminders.where((reminder) => reminder.isSelected).length;

  MainState copyWith({
    bool isSelectedModeActive,
    List<Reminder> reminders,
    String openedTitle,
    String openedDescription,
    DateTime openedDateTime,
  }) =>
      MainState(
        isSelectedModeActive: isSelectedModeActive ?? this.isSelectedModeActive,
        reminders: List<Reminder>()..addAll(reminders ?? this.reminders),
        openedTitle: openedTitle ?? this.openedTitle,
        openedDescription: openedDescription ?? this.openedDescription,
        openedDateTime: openedDateTime ?? this.openedDateTime,
      );

  factory MainState.initialState() => MainState(
        isSelectedModeActive: false,
        reminders: <Reminder>[],
        openedTitle: '',
        openedDescription: '',
        openedDateTime: DateTime.fromMillisecondsSinceEpoch(0),
      );

  @override
  List<Object> get props => [
        isSelectedModeActive,
        reminders,
        quantityOfSelectedItems,
        openedTitle,
        openedDescription,
        openedDateTime,
      ];
}
