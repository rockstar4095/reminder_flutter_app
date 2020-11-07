import 'package:flutter/material.dart';

class Reminder {
  final String title;
  final String description;
  final DateTime dateTime;

  Reminder({
    @required this.title,
    @required this.dateTime,
    this.description = '',
  });
}
