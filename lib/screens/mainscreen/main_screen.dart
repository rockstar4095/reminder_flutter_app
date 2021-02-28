import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_event.dart';
import 'package:reminder_flutter_app/generated/l10n.dart';
import 'package:reminder_flutter_app/screens/mainscreen/edit_reminder_dialog.dart';
import 'package:reminder_flutter_app/screens/mainscreen/reminder_item.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).reminders),
        actions: [
          _deleteIcon(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EditReminderDialog.open(context);
          context.read<MainBloc>().add(EditReminderDialogOpened());
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
              onPressed: () => context.read<MainBloc>().add(DeletePressed()));
        },
      );

  Widget _remindersList(BuildContext context) =>
      BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state.wereRemindersLoaded && state.reminders.isEmpty) {
            return _noRemindersPlaceholder(context);
          }

          return ListView.builder(
            itemCount: state.reminders.length,
            itemBuilder: (context, index) {
              return ReminderItem(reminders: state.reminders, index: index);
            },
          );
        },
      );

  Widget _noRemindersPlaceholder(BuildContext context) => Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 140),
          child: Text(
            S.of(context).noRemindersHint,
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 18),
          ),
        ),
      );
}
