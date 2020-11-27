import 'package:reminder_flutter_app/data/local/main_dao.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

class Repositories {
  Repositories._();

  static MainRepository mainRepository() => MainRepositoryImpl(MainDaoImpl());
}
