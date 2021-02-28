import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reminder_flutter_app/entity/product_entity.dart';

part 'reminder_entity.g.dart';

@HiveType(typeId: 0)
class ReminderEntity extends Equatable {
  @HiveField(0)
  final int index;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime dateTime;
  @HiveField(4)
  final bool isShoppingReminder;
  @HiveField(5)
  final List<ProductEntity> products;

  ReminderEntity({
    @required this.index,
    @required this.title,
    @required this.dateTime,
    this.description = '',
    @required this.isShoppingReminder,
    @required this.products,
  });

  ReminderEntity copyWith({
    int index,
    String title,
    String description,
    String dateTime,
    bool isShoppingReminder,
    bool products,
  }) =>
      ReminderEntity(
        index: index ?? this.index,
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        isShoppingReminder: isShoppingReminder ?? this.isShoppingReminder,
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [
        index,
        title,
        description,
        dateTime,
        isShoppingReminder,
        products,
      ];

  @override
  bool get stringify => true;
}
