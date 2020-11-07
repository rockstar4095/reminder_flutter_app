import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String ddMMyy() {
    final pattern = 'dd.MM.yy';
    final locale = 'ru_RU';
    final dateFormat = DateFormat(pattern, locale);
    return dateFormat.format(this);
  }
}