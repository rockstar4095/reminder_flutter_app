import 'package:hive/hive.dart';
import 'package:reminder_flutter_app/entity/reminder_entity.dart';

abstract class MainDao {
  Future<void> insertReminder(ReminderEntity reminderEntity);

  Future<void> deleteReminder(ReminderEntity reminderEntity);

  Future<void> updateReminder(ReminderEntity reminderEntity);

  Future<ReminderEntity> getReminder(int id);

  Future<List<ReminderEntity>> getAllReminders();
}

class MainDaoImpl implements MainDao {
  Box<ReminderEntity> _box;

  Future<Box<ReminderEntity>> _getBox() async {
    if (_box == null) {
      _box = await Hive.openBox<ReminderEntity>('remindersBox');
      return _box;
    }
    return _box;
  }

  @override
  Future<void> deleteReminder(ReminderEntity reminderEntity) async {
    final key = (await _getBox()).keyAt(reminderEntity.index);
    await (await _getBox()).delete(key);
  }

  @override
  Future<List<ReminderEntity>> getAllReminders() async {
    final length = (await _getBox()).length;
    final reminders = (await _getBox()).values.toList();
    return List.generate(
      length,
      (index) => reminders[index].copyWith(index: index),
    );
  }

  @override
  Future<ReminderEntity> getReminder(int id) {
    // TODO: implement getReminder
    return null;
  }

  @override
  Future<void> insertReminder(ReminderEntity reminderEntity) async =>
      (await _getBox()).add(reminderEntity);

  @override
  Future<void> updateReminder(ReminderEntity reminderEntity) {
    // TODO: implement updateReminder
  }
}
