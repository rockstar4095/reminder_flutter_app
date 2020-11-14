import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(selectedIndexes: <int>[]));

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is ItemSelected) {
      yield state.copyWith(
        isSelectedModeActive: true,
        lastSelectedIndex: event.index,
      );
    } else if (event is SelectModeDisabled) {
      yield state.copyWith(isSelectedModeActive: false);
    }
  }

  void onItemSelect(int index) {
    add(ItemSelected(index: index));

    final bool wasLastItemRemoved = state.selectedIndexes.length == 1 &&
        state.selectedIndexes.contains(index);
    if (wasLastItemRemoved) {
      add(SelectModeDisabled());
    }
  }

  void deleteReminders() {
    print('debug: delete reminders: ${state.selectedIndexes}');
  }
}
