import 'package:reminder_flutter_app/data/local/main_dao.dart';
import 'package:reminder_flutter_app/model/reminder.dart';

import 'converters.dart';

abstract class MainRepository {
  Future<Reminder> insertReminder(Reminder reminder);

  Future<void> deleteReminders(List<Reminder> reminders);

  Future<Reminder> updateReminder(Reminder reminder);

  Future<Reminder> getReminder(int id);

  Future<List<Reminder>> getAllReminders();
}

class MainRepositoryImpl implements MainRepository {
  final MainDao _mainDao;

  MainRepositoryImpl(this._mainDao);

  @override
  Future<Reminder> insertReminder(Reminder reminder) async =>
      (await _mainDao.insertReminder(reminder.toReminderEntity())).toReminder();

  @override
  Future<Reminder> getReminder(int id) async =>
      (await _mainDao.getReminder(id)).toReminder();

  @override
  Future<Reminder> updateReminder(Reminder reminder) async =>
      (await _mainDao.updateReminder(reminder.toReminderEntity())).toReminder();

  @override
  Future<void> deleteReminders(List<Reminder> reminders) async =>
      reminders.forEach((reminder) =>
        _mainDao.deleteReminder(reminder.toReminderEntity())
      );

  @override
  Future<List<Reminder>> getAllReminders() async =>
      (await _mainDao.getAllReminders()).toRemindersList();
}
