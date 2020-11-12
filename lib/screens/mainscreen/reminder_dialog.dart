import 'package:flutter/material.dart';

class ReminderDialog {
  static void open(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => _ReminderDialog(),
      );
}

class _ReminderDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: _body(context),
          ),
        ),
      ),
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
