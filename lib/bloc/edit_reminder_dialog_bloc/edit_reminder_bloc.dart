import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_event.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

part 'edit_reminder_event.dart';
part 'edit_reminder_state.dart';

class EditReminderBloc extends Bloc<EditReminderEvent, EditReminderState> {
  final MainRepository _repository;
  final MainBloc _mainBloc;
  final int currentReminderId;

  EditReminderBloc(
    this._repository,
    this._mainBloc,
    this.currentReminderId,
  ) : super(EditReminderState.initialState()) {
    if (currentReminderId != null) {
      _openReminder(currentReminderId);
    }
  }

  @override
  Stream<EditReminderState> mapEventToState(EditReminderEvent event) async* {
    if (event is SavePressed) {
      _isReminderUpdate()
          ? await _updateReminder(event.reminder)
          : await _saveReminder(event.reminder);
      _mainBloc.add(SaveReminderPressed());
    } else if (event is TitleChanged) {
      yield state.copyWith(title: event.title);
    } else if (event is DescriptionChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is DateChanged) {
      yield state.copyWith(date: event.date);
    } else if (event is TimeChanged) {
      yield state.copyWith(time: event.time);
    } else if (event is ExistingReminderOpened) {
      final reminder = event.reminder;
      yield state.copyWith(
        title: reminder.title,
        description: reminder.description,
        date: _getReminderDate(reminder.dateTime),
        time: _getReminderTime(reminder.dateTime),
      );
    }
  }

  DateTime _getReminderDate(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  TimeOfDay _getReminderTime(DateTime dateTime) =>
      TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);

  Future<void> _saveReminder(Reminder reminder) =>
      _repository.insertReminder(reminder);

  Future<void> _updateReminder(Reminder reminder) =>
      _repository.updateReminder(reminder);

  Future<void> _openReminder(int id) async {
    add(ExistingReminderOpened(reminder: await _getReminder(id)));
  }

  bool _isReminderUpdate() => currentReminderId != null;

  Future<Reminder> _getReminder(int id) => _repository.getReminder(id);
}
