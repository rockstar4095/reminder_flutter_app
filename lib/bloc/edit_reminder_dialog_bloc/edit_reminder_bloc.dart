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

  EditReminderBloc(
    this._repository,
    this._mainBloc,
  ) : super(
          EditReminderState(
            title: '',
            description: '',
            date: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
            time: TimeOfDay.now(),
          ),
        );

  @override
  Stream<EditReminderState> mapEventToState(EditReminderEvent event) async* {
    if (event is SavePressed) {
      await _saveReminder(event.reminder);
      _mainBloc.add(SaveReminderPressed());
    } else if (event is TitleChanged) {
      yield state.copyWith(title: event.title);
    } else if (event is DescriptionChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is DateChanged) {
      yield state.copyWith(date: event.date);
    } else if (event is TimeChanged) {
      yield state.copyWith(time: event.time);
    }
  }

  Future<void> _saveReminder(Reminder reminder) =>
      _repository.insertReminder(reminder);
}
