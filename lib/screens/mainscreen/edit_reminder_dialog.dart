import 'package:flutter/material.dart';
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
            _titleField(),
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
                _save(),
                _cancel(context),
              ],
            ),
          ],
        ),
      );

  Widget _titleField() => TextField(
        decoration: InputDecoration(
          hintText: 'Название',
        ),
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

  Widget _save() => RaisedButton(
        child: Text('Сохранить'),
        onPressed: () {},
      );

  Widget _cancel(BuildContext context) => RaisedButton(
        child: Text('Отменить'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
}
