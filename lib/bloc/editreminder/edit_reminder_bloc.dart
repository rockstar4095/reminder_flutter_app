import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_event.dart';
import 'package:reminder_flutter_app/model/product.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:reminder_flutter_app/utils/notifications.dart';

part 'edit_reminder_event.dart';
part 'edit_reminder_state.dart';

class EditReminderBloc extends Bloc<EditReminderEvent, EditReminderState> {
  final MainRepository repository;
  final MainBloc mainBloc;
  final int currentReminderId;
  final Notifications notifications;
  String _title = '';
  String _description = '';

  String get title => _title;

  String get description => _description;

  EditReminderBloc({
    @required this.repository,
    @required this.mainBloc,
    @required this.currentReminderId,
    @required this.notifications,
  })  : assert(repository != null),
        assert(mainBloc != null),
        assert(currentReminderId != null),
        assert(notifications != null),
        super(EditReminderState.initialState()) {
    if (currentReminderId != null) {
      _openReminder(currentReminderId);
    }
  }

  @override
  Stream<EditReminderState> mapEventToState(EditReminderEvent event) async* {
    if (event is SavePressed) {
      final insertedReminder = _isReminderUpdate()
          ? await _updateReminder(event.reminder)
          : await _saveReminder(event.reminder);
      mainBloc.add(SaveReminderPressed());
      await _saveNotification(insertedReminder);
    } else if (event is TitleChanged) {
      _title = event.title;
    } else if (event is DescriptionChanged) {
      _description = event.description;
    } else if (event is DateChanged) {
      yield state.copyWith(date: event.date);
    } else if (event is TimeChanged) {
      yield state.copyWith(time: event.time);
    } else if (event is ExistingReminderOpened) {
      final reminder = event.reminder;

      if (reminder.isShoppingReminder) {
        _title = '';
      } else {
        _title = reminder.title;
      }

      _description = reminder.description;
      yield state.copyWith(
        title: reminder.title,
        description: reminder.description,
        date: _getReminderDate(reminder.dateTime),
        time: _getReminderTime(reminder.dateTime),
        isShoppingReminder: reminder.isShoppingReminder,
        products: reminder.products,
      );
    } else if (event is ShoppingReminderSwitched) {
      yield state.copyWith(isShoppingReminder: event.isShoppingReminder);
    }
  }

  DateTime _getReminderDate(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  TimeOfDay _getReminderTime(DateTime dateTime) =>
      TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);

  Future<Reminder> _saveReminder(Reminder reminder) =>
      repository.insertReminder(reminder);

  Future<Reminder> _updateReminder(Reminder reminder) =>
      repository.updateReminder(reminder);

  Future<Reminder> _getReminder(int id) => repository.getReminder(id);

  bool _isReminderUpdate() => currentReminderId != null;

  Future<void> _openReminder(int id) async =>
      add(ExistingReminderOpened(reminder: await _getReminder(id)));

  _saveNotification(Reminder reminder) =>
      notifications.saveNotification(reminder);
}
