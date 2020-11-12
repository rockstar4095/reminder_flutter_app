import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_event.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(RegularMainState());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is SelectModeActivated) {
      print('debug: SelectModeActivated');
      yield RegularMainState();
    }
  }
}
