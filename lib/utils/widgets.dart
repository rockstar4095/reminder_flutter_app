import 'package:flutter/material.dart';

Widget modalBottomSheet({Widget body}) => Container(
  height: double.infinity,
  alignment: Alignment.center,
  child: SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: body,
    ),
  ),
);