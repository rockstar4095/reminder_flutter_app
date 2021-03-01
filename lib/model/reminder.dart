import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reminder_flutter_app/model/product.dart';

class Reminder extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isSelected;
  final bool isShoppingReminder;
  final Set<Product> products;

  Reminder({
    @required this.id,
    @required this.title,
    @required this.dateTime,
    this.description = '',
    this.isSelected = false,
    @required this.isShoppingReminder,
    @required this.products,
  });

  Reminder copyWith({
    int id,
    String title,
    String description,
    DateTime dateTime,
    bool isSelected,
    bool isShoppingReminder,
    Set<Product> products,
  }) =>
      Reminder(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        isSelected: isSelected ?? this.isSelected,
        isShoppingReminder: isShoppingReminder ?? this.isShoppingReminder,
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [
        id,
        title,
        description,
        dateTime,
        isSelected,
        isShoppingReminder,
        products,
      ];

  @override
  bool get stringify => true;
}
