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
            dateTime: DateTime.fromMillisecondsSinceEpoch(0),
          ),
        );

  @override
  Stream<EditReminderState> mapEventToState(EditReminderEvent event) async* {
    if (event is SavePressed) {
      await _saveReminder(event.reminder);
      _mainBloc.add(SaveReminderPressed());
    }
  }

  Future<void> _saveReminder(Reminder reminder) =>
      _repository.insertReminder(reminder);
}
