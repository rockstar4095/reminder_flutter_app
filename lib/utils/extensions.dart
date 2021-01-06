import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String ddMMyy() {
    final pattern = 'dd.MM.yy';
    // TODO fix locale initialization.
    // final locale = 'ru_RU';
    final dateFormat = DateFormat(pattern /*, locale*/);
    return dateFormat.format(this);
  }

  String hhmm() => DateFormat.Hm().format(this);
}

extension DateComparator on DateTime {
  bool isSameDate(DateTime other) =>
      other.year == year && other.month == month && other.day == day;

  bool isNotSameDate(DateTime other) => !this.isSameDate(other);
}
