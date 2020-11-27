part of 'main_bloc.dart';

class MainState extends Equatable {
  final bool isSelectedModeActive;
  final List<Reminder> reminders;
  final int quantityOfSelectedItems;

  MainState({
    this.isSelectedModeActive = false,
    this.reminders,
  }) : quantityOfSelectedItems =
            reminders.where((reminder) => reminder.isSelected).length;

  MainState copyWith({
    bool isSelectedModeActive,
    List<Reminder> reminders,
  }) =>
      MainState(
        isSelectedModeActive: isSelectedModeActive ?? this.isSelectedModeActive,
        reminders: List<Reminder>()..addAll(reminders ?? this.reminders),
      );

  @override
  List<Object> get props => [
        isSelectedModeActive,
        reminders,
        quantityOfSelectedItems,
      ];
}
