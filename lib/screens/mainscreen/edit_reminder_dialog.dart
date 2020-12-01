import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/edit_reminder_dialog_bloc/edit_reminder_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_bloc.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:reminder_flutter_app/utils/extensions.dart';
import 'package:reminder_flutter_app/utils/widgets.dart';

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
            _titleField(context),
            _descriptionField(context),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _dateField(context),
                _timeField(context),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _save(context),
                _cancel(context),
              ],
            ),
          ],
        ),
      );

  Widget _titleField(BuildContext context) =>
      BlocBuilder<EditReminderBloc, EditReminderState>(
        buildWhen: (previous, current) =>
            previous.title.isEmpty && previous.title != current.title,
        builder: (context, state) {
          TextEditingController controller = TextEditingController();
          if (state.title.isNotEmpty) {
            controller.text = state.title;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          }
          return TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Название'),
            onChanged: (input) => context.read<EditReminderBloc>().add(
                  TitleChanged(title: input),
                ),
          );
        },
      );

  Widget _descriptionField(BuildContext context) =>
      BlocBuilder<EditReminderBloc, EditReminderState>(
        buildWhen: (previous, current) =>
            previous.description.isEmpty &&
            previous.description != current.description,
        builder: (context, state) {
          TextEditingController controller = TextEditingController();
          if (state.description.isNotEmpty) {
            controller.text = state.description;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          }
          return TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(hintText: 'Описание'),
            onChanged: (input) => context.read<EditReminderBloc>().add(
                  DescriptionChanged(description: input),
                ),
          );
        },
      );

  Widget _dateField(BuildContext context) =>
      BlocBuilder<EditReminderBloc, EditReminderState>(
        buildWhen: (previous, current) => previous.date != current.date,
        builder: (context, state) => FlatButton(
          child: Text(state.date.ddMMyy()),
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
        builder: (context, state) => FlatButton(
          child: Text(state.time.format(context)),
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

  Widget _save(BuildContext context) => RaisedButton(
        child: Text('Сохранить'),
        onPressed: () {
          final title = context.read<EditReminderBloc>().state.title;
          if (title.isEmpty) {
            _showEmptyTitleSnack(context);
            return;
          }

          final reminder = _formReminder(context);
          context.read<EditReminderBloc>().add(SavePressed(reminder: reminder));
          Navigator.of(context).pop();
        },
      );

  void _showEmptyTitleSnack(BuildContext context) =>
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Укажите название'),
        ),
      );

  Reminder _formReminder(BuildContext context) => Reminder(
        id: context.read<EditReminderBloc>().currentReminderId,
        title: context.read<EditReminderBloc>().state.title,
        description: context.read<EditReminderBloc>().state.description,
        dateTime: _getDateTime(context),
      );

  DateTime _getDateTime(BuildContext context) => DateTime(
        context.read<EditReminderBloc>().state.date.year,
        context.read<EditReminderBloc>().state.date.month,
        context.read<EditReminderBloc>().state.date.day,
        context.read<EditReminderBloc>().state.time.hour,
        context.read<EditReminderBloc>().state.time.minute,
      );

  Widget _cancel(BuildContext context) => RaisedButton(
        child: Text('Отменить'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
}
