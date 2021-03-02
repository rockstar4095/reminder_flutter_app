import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_bloc.dart';
import 'package:reminder_flutter_app/bloc/viewreminder/view_reminder_bloc.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:reminder_flutter_app/utils/notifications.dart';
import 'package:reminder_flutter_app/utils/wakelock.dart';

class Blocs {
  Blocs._();

  static MainBloc mainBloc(BuildContext context) => MainBloc(
        repository: context.read<MainRepository>(),
        notifications: context.read<Notifications>(),
      );

  static ViewReminderBloc viewReminderBloc(BuildContext context) =>
      ViewReminderBloc(
        repository: context.read<MainRepository>(),
        wakeLock: context.read<WakeLock>(),
      );
}
