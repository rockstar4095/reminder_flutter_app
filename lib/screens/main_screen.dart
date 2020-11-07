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
  Reminder(title: 'title', dateTime: DateTime.parse('1970-01-01T00:00:00.000000Z')),
];
