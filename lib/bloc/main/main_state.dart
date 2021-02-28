part of 'main_bloc.dart';

class MainState extends Equatable {
  final bool isSelectedModeActive;
  final List<Reminder> reminders;
  final int quantityOfSelectedItems;
  final bool wereRemindersLoaded;

  MainState({
    @required this.isSelectedModeActive,
    @required this.reminders,
    @required this.wereRemindersLoaded,
  }) : quantityOfSelectedItems =
            reminders.where((reminder) => reminder.isSelected).length;

  MainState copyWith({
    bool isSelectedModeActive,
    List<Reminder> reminders,
    String openedTitle,
    String openedDescription,
    DateTime openedDateTime,
    bool wereTripsLoaded,
    bool openedIsShoppingReminder,
  }) =>
      MainState(
        isSelectedModeActive: isSelectedModeActive ?? this.isSelectedModeActive,
        reminders: List<Reminder>()..addAll(reminders ?? this.reminders),
        wereRemindersLoaded: wereTripsLoaded ?? this.wereRemindersLoaded,
      );

  factory MainState.initialState() => MainState(
        isSelectedModeActive: false,
        reminders: <Reminder>[],
        wereRemindersLoaded: false,
      );

  @override
  List<Object> get props => [
        isSelectedModeActive,
        reminders,
        quantityOfSelectedItems,
        wereRemindersLoaded,
      ];
}
