import 'package:flutter/material.dart';

class Reminder {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;

  Reminder({
    @required this.id,
    @required this.title,
    @required this.dateTime,
    this.description = '',
  });
}
