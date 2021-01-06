import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/editreminder/edit_reminder_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_bloc.dart';
import 'package:reminder_flutter_app/generated/l10n.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:reminder_flutter_app/utils/extensions.dart';
import 'package:reminder_flutter_app/utils/widgets.dart';
import 'package:reminder_flutter_app/widget/buttons.dart';

class EditReminderDialog {
  static void open(BuildContext context, {int reminderId}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => BlocProvider(
          create: (context) => EditReminderBloc(
            context.read<MainRepository>(),
            context.read<MainBloc>(),
            reminderId,
          ),
          // Scaffold wrapper to be able to show SnackBar
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: _EditReminderDialog(),
          ),
        ),
      );
}

class _EditReminderDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: modalBottomSheet(body: _body(context)),
    );
  }

  Widget _body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 4),
            _titleField(context),
            SizedBox(height: 8),
            _descriptionField(context),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 16),
                Expanded(child: _dateField(context)),
                SizedBox(width: 16),
                Expanded(child: _timeField(context)),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  _save(context),
                  SizedBox(height: 8),
                  _cancel(context),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _titleField(BuildContext context) =>
      BlocBuilder<EditReminderBloc, EditReminderState>(
        buildWhen: (previous, current) =>
            previous.editedTitle.isEmpty && current.editedTitle.isNotEmpty,
        builder: (context, state) {
          // key is used to paste initial value from changing state.
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              key: Key(state.editedTitle),
              initialValue: state.editedTitle,
              decoration: InputDecoration(hintText: S.of(context).titleHint),
              onChanged: (input) => context.read<EditReminderBloc>().add(
                    TitleChanged(title: input),
                  ),
            ),
          );
        },
      );

  Widget _descriptionField(BuildContext context) =>
      BlocBuilder<EditReminderBloc, EditReminderState>(
        buildWhen: (previous, current) =>
            previous.editedDescription.isEmpty &&
            current.editedDescription.isNotEmpty,
        builder: (context, state) {
          // key is used to paste initial value from changing state.
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              key: Key(state.editedDescription),
              initialValue: state.editedDescription,
              decoration:
                  InputDecoration(hintText: S.of(context).descriptionHint),
              maxLines: state.editedDescription.isEmpty ? 3 : null,
              onChanged: (input) => context.read<EditReminderBloc>().add(
                    DescriptionChanged(description: input),
                  ),
            ),
          );
        },
      );

  Widget _dateField(BuildContext context) =>
      BlocBuilder<EditReminderBloc, EditReminderState>(
        buildWhen: (previous, current) => previous.date != current.date,
        builder: (context, state) => AppTextButton(
          margin: const EdgeInsets.all(0),
          child: Text(
            state.date.ddMMyy(),
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          onPressed: () {
            _unFocus(context);
            _showDatePicker(context);
          },
        ),
      );

  Future<void> _showDatePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2199),
    );

    context.read<EditReminderBloc>().add(DateChanged(date: date));
  }

  Widget _timeField(BuildContext context) =>
      BlocBuilder<EditReminderBloc, EditReminderState>(
        buildWhen: (previous, current) => previous.time != current.time,
        builder: (context, state) => AppTextButton(
          margin: const EdgeInsets.all(0),
          child: Text(
            state.time.format(context),
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          onPressed: () {
            _unFocus(context);
            _showTimePicker(context);
          },
        ),
      );

  Future<void> _showTimePicker(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    context.read<EditReminderBloc>().add(TimeChanged(time: time));
  }

  void _unFocus(BuildContext context) {
    FocusScopeNode focusScope = FocusScope.of(context);
    if (!focusScope.hasPrimaryFocus) {
      focusScope.unfocus();
    }
  }

  Widget _save(BuildContext context) => PrimaryButton(
        text: S.of(context).saveButton,
        onPressed: () {
          final title = context.read<EditReminderBloc>().title;
          if (title.isEmpty) {
            _showEmptyTitleSnack(context);
            return;
          }

          final reminder = _formReminder(context);
          context.read<EditReminderBloc>().add(SavePressed(reminder: reminder));
          Navigator.of(context).pop();
        },
      );

  Widget _cancel(BuildContext context) => AppTextButton(
        child: Text(
          S.of(context).cancelButton,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );

  void _showEmptyTitleSnack(BuildContext context) =>
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).specifyTitle),
        ),
      );

  Reminder _formReminder(BuildContext context) => Reminder(
        id: context.read<EditReminderBloc>().currentReminderId,
        title: context.read<EditReminderBloc>().title,
        description: context.read<EditReminderBloc>().description,
        dateTime: _getDateTime(context),
      );

  DateTime _getDateTime(BuildContext context) => DateTime(
        context.read<EditReminderBloc>().state.date.year,
        context.read<EditReminderBloc>().state.date.month,
        context.read<EditReminderBloc>().state.date.day,
        context.read<EditReminderBloc>().state.time.hour,
        context.read<EditReminderBloc>().state.time.minute,
      );
}
