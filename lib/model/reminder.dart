import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Reminder extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isSelected;

  Reminder({
    @required this.id,
    @required this.title,
    @required this.dateTime,
    this.description = '',
    this.isSelected = false,
  });

  Reminder copyWith({
    int id,
    String title,
    String description,
    DateTime dateTime,
    bool isSelected,
  }) =>
      Reminder(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  List<Object> get props => [
        id,
        title,
        description,
        dateTime,
        isSelected,
      ];
}
