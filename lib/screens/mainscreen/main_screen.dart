import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_event.dart';
import 'package:reminder_flutter_app/screens/mainscreen/edit_reminder_dialog.dart';
import 'package:reminder_flutter_app/screens/mainscreen/reminder_item.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      appBar: AppBar(
        title: Text('Напоминания'),
        actions: [
          _deleteIcon(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EditReminderDialog.open(context);
        },
        child: Icon(Icons.add),
      ),
      body: _remindersList(context),
    );

    return BlocProvider(
      create: (context) => context.read<MainBloc>(),
      child: content,
    );
  }

  Widget _deleteIcon(BuildContext context) => BlocBuilder<MainBloc, MainState>(
        buildWhen: (previous, current) =>
            current.isSelectedModeActive != previous.isSelectedModeActive,
        builder: (context, state) {
          if (!state.isSelectedModeActive) return SizedBox();

          return IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<MainBloc>().add(DeletePressed());
            },
          );
        },
      );

  Widget _remindersList(BuildContext context) =>
      BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.reminders.length,
            itemBuilder: (context, index) {
              return ReminderItem(reminders: state.reminders, index: index);
            },
          );
        },
      );
}
