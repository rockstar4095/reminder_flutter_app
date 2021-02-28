import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 2)
class ProductEntity extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool isChecked;

  ProductEntity({
    @required this.name,
    @required this.isChecked,
  });

  @override
  List<Object> get props => [
        name,
        isChecked,
      ];

  @override
  bool get stringify => true;
}
