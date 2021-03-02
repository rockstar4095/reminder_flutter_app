import 'package:reminder_flutter_app/data/local/main_dao.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:reminder_flutter_app/utils/notifications.dart';
import 'package:reminder_flutter_app/utils/wakelock.dart';

class Repositories {
  Repositories._();

  static MainRepository mainRepository() => MainRepositoryImpl(MainDaoImpl());

  static WakeLock wakeLock() => WakeLockImpl();

  static Notifications notifications() => NotificationsImpl();
}
