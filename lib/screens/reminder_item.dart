import 'package:flutter/material.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/utils/date_time_formatter.dart';

class ReminderItem extends StatelessWidget {
  final List<Reminder> reminders;
  final int index;

  ReminderItem({
    @required this.reminders,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final current = reminders[index];
    final previous = index > 0 ? reminders[index - 1] : null;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Expanded(child: Text(current.title)),
          Text(current.dateTime.ddMMyy()),
        ],
      ),
    );
  }
}
