import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/edit_reminder_dialog_bloc/edit_reminder_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_bloc.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';

class Blocs {
  Blocs._();

  static MainBloc mainBloc(BuildContext context) =>
      MainBloc(context.read<MainRepository>());

  static EditReminderBloc editReminderBloc(BuildContext context) =>
      EditReminderBloc(
        context.read<MainRepository>(),
        context.read<MainBloc>(),
      );
}
