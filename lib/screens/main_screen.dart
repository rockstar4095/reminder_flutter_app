import 'package:flutter/material.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/screens/reminder_item.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Напоминания'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: _remindersList(context, _reminders),
    );
  }

  Widget _remindersList(BuildContext context, List<Reminder> reminders) =>
      ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return ReminderItem(reminders: reminders, index: index);
        },
      );
}

final _reminders = [
  Reminder(
    title: 'Убрать в комнате',
    dateTime: DateTime.parse('2020-11-08T01:50:00.000000Z'),
    description: 'поменять перегоревшую лампочку',
  ),
  Reminder(
    title: 'Оплатить кредит',
    dateTime: DateTime.parse('2020-11-09T21:45:00.000000Z'),
  ),
  Reminder(
    title: 'Поздравить Васю с др',
    dateTime: DateTime.parse('2020-11-09T12:54:00.000000Z'),
  ),
];
