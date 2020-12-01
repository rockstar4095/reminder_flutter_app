import 'package:hive/hive.dart';
import 'package:reminder_flutter_app/entity/reminder_entity.dart';

abstract class MainDao {
  Future<ReminderEntity> insertReminder(ReminderEntity reminderEntity);

  Future<void> deleteReminder(ReminderEntity reminderEntity);

  Future<ReminderEntity> updateReminder(ReminderEntity reminderEntity);

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
  Future<void> deleteReminder(ReminderEntity reminderEntity) async =>
      await (await _getBox()).delete(reminderEntity.index);

  @override
  Future<List<ReminderEntity>> getAllReminders() async {
    final length = (await _getBox()).length;
    final keys = (await _getBox()).keys.toList();
    final reminders = (await _getBox()).values.toList();
    return List.generate(
      length,
      (index) => reminders[index].copyWith(index: keys[index]),
    );
  }

  @override
  Future<ReminderEntity> getReminder(int id) async =>
      (await _getBox()).get(id).copyWith(index: id);

  @override
  Future<ReminderEntity> insertReminder(ReminderEntity reminderEntity) async {
    final index = await (await _getBox()).add(reminderEntity);
    final insertedReminder = await getReminder(index);
    return insertedReminder;
  }

  @override
  Future<ReminderEntity> updateReminder(ReminderEntity reminderEntity) async {
    (await _getBox()).put(reminderEntity.index, reminderEntity);
    return getReminder(reminderEntity.index);
  }
}
