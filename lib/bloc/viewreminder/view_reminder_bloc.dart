import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reminder_flutter_app/model/product.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:reminder_flutter_app/utils/wakelock.dart';

part 'view_reminder_event.dart';
part 'view_reminder_state.dart';

class ViewReminderBloc extends Bloc<ViewReminderEvent, ViewReminderState> {
  final MainRepository repository;
  final WakeLock wakeLock;

  ViewReminderBloc({
    @required this.repository,
    @required this.wakeLock,
  })  : assert(repository != null),
        assert(wakeLock != null),
        super(ViewReminderState(
          reminder: Reminder(
            title: '',
            description: '',
            dateTime: DateTime.now(),
            isSelected: false,
            isShoppingReminder: false,
            id: 0,
            products: [],
          ),
        ));

  @override
  Stream<ViewReminderState> mapEventToState(ViewReminderEvent event) async* {
    if (event is ReminderLoaded) {
      if (event.reminder.isShoppingReminder) wakeLock.turnOn();
      yield ViewReminderState(reminder: event.reminder);
    } else if (event is ReminderOpened) {
      _loadReminder(event.reminderId);
    } else if (event is ProductCheckChanged) {
      final reminder = event.reminder;
      final List<Product> products = []..addAll(reminder.products ?? []);

      products.removeWhere((e) => e.name == event.product.name);
      products.add(event.product);

      await _updateReminder(reminder.copyWith(products: products));
      _loadReminder(reminder.id);
    } else if (event is DialogClosed) {
      if (await wakeLock.isOn()) {
        wakeLock.turnOff();
      }
    }
  }

  Future<void> _loadReminder(int id) async {
    final reminder = await _getReminder(id);
    add(ReminderLoaded(reminder: reminder));
  }

  Future<Reminder> _getReminder(int id) => repository.getReminder(id);

  Future<void> _updateReminder(Reminder reminder) =>
      repository.updateReminder(reminder);
}
