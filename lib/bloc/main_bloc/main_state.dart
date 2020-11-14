part of 'main_bloc.dart';

class MainState extends Equatable {
  final bool isSelectedModeActive;
  final int lastSelectedIndex;
  final List<int> selectedIndexes;

  MainState({
    this.isSelectedModeActive = false,
    this.lastSelectedIndex,
    this.selectedIndexes,
  });

  MainState copyWith({
    bool isSelectedModeActive,
    int lastSelectedIndex,
  }) =>
      MainState(
        isSelectedModeActive: isSelectedModeActive ?? this.isSelectedModeActive,
        lastSelectedIndex: lastSelectedIndex ?? this.lastSelectedIndex,
        selectedIndexes: List<int>()..addAll(selectedIndexes),
      ).._addRemoveIndex(lastSelectedIndex);

  void _addRemoveIndex(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      if (index == null) return;
      selectedIndexes.add(index);
    }
  }

  @override
  List<Object> get props => [
        isSelectedModeActive,
        lastSelectedIndex,
        selectedIndexes,
      ];
}
