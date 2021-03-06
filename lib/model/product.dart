import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable {
  final String name;
  final bool isChecked;

  Product({
    @required this.name,
    @required this.isChecked,
  });

  Product copyWith({
    @required isChecked,
  }) =>
      Product(
        name: this.name,
        isChecked: isChecked ?? this.isChecked,
      );

  @override
  List<Object> get props => [
        name,
        isChecked,
      ];

  @override
  bool get stringify => true;
}
