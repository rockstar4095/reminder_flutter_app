import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'reminder_entity.g.dart';

@HiveType(typeId: 0)
class ReminderEntity {
  @HiveField(0)
  final int index;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime dateTime;

  ReminderEntity({
    @required this.index,
    @required this.title,
    @required this.dateTime,
    this.description = '',
  });

  ReminderEntity copyWith({
    int index,
    String title,
    String description,
    String dateTime,
  }) =>
      ReminderEntity(
        index: index ?? this.index,
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
      );
}
