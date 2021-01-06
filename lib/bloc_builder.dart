import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_bloc.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

class Blocs {
  Blocs._();

  static MainBloc mainBloc(BuildContext context) =>
      MainBloc(context.read<MainRepository>());
}
