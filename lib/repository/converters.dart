import 'package:reminder_flutter_app/entity/reminder_entity.dart';
import 'package:reminder_flutter_app/model/reminder.dart';

extension ReminderToReminderEntity on Reminder {
  ReminderEntity toReminderEntity() => ReminderEntity(
        index: id,
        title: title,
        description: description,
        dateTime: dateTime,
      );
}

extension RemindersToReminderEntitites on List<Reminder> {
  List<ReminderEntity> toReminderEntitiesList() {
    if (this == null) return null;
    return List.generate(
      length,
      (index) => this[index].toReminderEntity(),
    );
  }
}

extension ReminderEntityToReminder on ReminderEntity {
  Reminder toReminder() => Reminder(
        id: index,
        title: title,
        description: description,
        dateTime: dateTime,
      );
}

extension ReminderEnititesToRemonders on List<ReminderEntity> {
  List<Reminder> toRemindersList() {
    if (this == null) return [];
    return List.generate(
      length,
      (index) => this[index].toReminder(),
    );
  }
}
