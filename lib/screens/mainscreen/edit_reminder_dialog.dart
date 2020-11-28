import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/edit_reminder_dialog_bloc/edit_reminder_bloc.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/utils/widgets.dart';

class EditReminderDialog {
  static void open(BuildContext context, {int reminderId}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => _EditReminderDialog(reminderId: reminderId),
      );
}

class _EditReminderDialog extends StatelessWidget {
  final int reminderId;

  _EditReminderDialog({this.reminderId});

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
            _descriptionField(),
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

  Widget _titleField(BuildContext context) => TextField(
        decoration: InputDecoration(
          hintText: 'Название',
        ),
        onChanged: (input) =>
            context.read<EditReminderBloc>().add(TitleChanged(title: input)),
      );

  Widget _descriptionField() => TextField(
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Описание',
        ),
      );

  Widget _dateField(BuildContext context) => FlatButton(
        child: Text('12.11.2020'),
        onPressed: () {
          _unFocus(context);
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now(),
          );
        },
      );

  Widget _timeField(BuildContext context) => FlatButton(
        child: Text('00:21'),
        onPressed: () {
          _unFocus(context);
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
        },
      );

  void _unFocus(BuildContext context) {
    FocusScopeNode focusScope = FocusScope.of(context);
    if (!focusScope.hasPrimaryFocus) {
      focusScope.unfocus();
    }
  }

  Widget _save(BuildContext context) => RaisedButton(
        child: Text('Сохранить'),
        onPressed: () {
          final reminder = Reminder(
            id: null,
            title: 'test reminder title',
            description: 'test reminder description ${DateTime.now().toLocal()}',
            dateTime: DateTime.now(),
          );

          context.read<EditReminderBloc>().add(SavePressed(reminder: reminder));
          Navigator.of(context).pop();
        },
      );

  Widget _cancel(BuildContext context) => RaisedButton(
        child: Text('Отменить'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
}
