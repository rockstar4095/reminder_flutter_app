import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reminder_flutter_app/model/product.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

part 'view_reminder_event.dart';
part 'view_reminder_state.dart';

class ViewReminderBloc extends Bloc<ViewReminderEvent, ViewReminderState> {
  final MainRepository _repository;

  ViewReminderBloc(this._repository)
      : super(ViewReminderState(
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
    }
  }

  Future<void> _loadReminder(int id) async {
    final reminder = await _getReminder(id);
    add(ReminderLoaded(reminder: reminder));
  }

  Future<Reminder> _getReminder(int id) => _repository.getReminder(id);

  Future<void> _updateReminder(Reminder reminder) =>
      _repository.updateReminder(reminder);
}
