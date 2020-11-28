import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_event.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository _repository;

  MainBloc(this._repository)
      : super(
          MainState(reminders: <Reminder>[]),
        ) {
    // _repository.insertReminder(Reminder(
    //   id: 0,
    //   title: 'Убрать в комнате',
    //   dateTime: DateTime.parse('2020-11-08T01:50:00.000000Z'),
    //   description: 'поменять перегоревшую лампочку',
    // ));
    // _repository.insertReminder(Reminder(
    //   id: 1,
    //   title: 'Оплатить кредит',
    //   dateTime: DateTime.parse('2020-11-09T21:45:00.000000Z'),
    // ));
    // _repository.insertReminder(Reminder(
    //   id: 2,
    //   title: 'Поздравить Васю с др',
    //   dateTime: DateTime.parse('2020-11-09T12:54:00.000000Z'),
    // ));
    _loadReminders();
  }

  void _loadReminders() async {
    final reminders = await _repository.getAllReminders();
    reminders.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : -1);
    if (reminders.isNotEmpty) {
      add(RemindersLoaded(reminders: reminders));
    }
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is ItemSelected) {
      yield state.copyWith(isSelectedModeActive: true);
    } else if (event is SelectModeDisabled) {
      yield state.copyWith(isSelectedModeActive: false);
    } else if (event is RemindersLoaded) {
      yield state.copyWith(reminders: event.reminders);
    } else if (event is SaveReminderPressed) {

      // list with reminders (main_screen.dart) doesn't rebuild after this
      await _saveReminder(event.reminder);
      _loadReminders();
    } else if (event is DeletePressed) {
      await deleteReminders();
      _loadReminders();
      add(SelectModeDisabled());
    }
  }

  void onItemSelect(int reminderId) {
    final reminder =
        state.reminders.singleWhere((reminder) => reminder.id == reminderId);
    final reminderIndex = state.reminders.indexOf(reminder);
    state.reminders[reminderIndex] =
        reminder.copyWith(isSelected: !reminder.isSelected);

    add(ItemSelected(reminders: state.reminders));

    final selectedRemindersQuantity =
        state.reminders.where((reminder) => reminder.isSelected).length;
    if (selectedRemindersQuantity == 0) {
      add(SelectModeDisabled());
    }
  }

  Future<void> deleteReminders() async => _repository.deleteReminders(
        state.reminders.where((reminder) => reminder.isSelected).toList(),
      );

  Future<void> _saveReminder(Reminder reminder) =>
      _repository.insertReminder(reminder);
}
