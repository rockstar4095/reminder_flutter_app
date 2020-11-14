import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemSelected extends MainEvent {
  final int index;

  ItemSelected({
    @required this.index,
  });

  @override
  List<Object> get props => [index];
}

class SelectModeDisabled extends MainEvent {}
