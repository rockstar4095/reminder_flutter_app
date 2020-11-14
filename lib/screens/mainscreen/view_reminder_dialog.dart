import 'package:flutter/material.dart';
import 'package:reminder_flutter_app/screens/mainscreen/edit_reminder_dialog.dart';
import 'package:reminder_flutter_app/utils/widgets.dart';

class ViewReminderDialog {
  static void open(BuildContext context, int reminderId) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => _ViewReminderDialog(reminderId),
      );
}

class _ViewReminderDialog extends StatelessWidget {
  final int reminderId;

  _ViewReminderDialog(this.reminderId);

  @override
  Widget build(BuildContext context) {
    return modalBottomSheet(body: _body(context));
  }

  Widget _body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Stack(
              children: [
                _title(context),
                _closeDialogButton(context),
              ],
            ),
            SizedBox(height: 12),
            _reminderTitle(context),
            SizedBox(height: 24),
            _reminderDescription(context),
            SizedBox(height: 24),
            _editButton(context),
          ],
        ),
      );

  Widget _closeDialogButton(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );

  Widget _title(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            '14.11.20 в 12:25',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      );

  Widget _reminderTitle(BuildContext context) => Text(
        'Сходить в магазин',
        style: Theme.of(context).textTheme.headline6,
      );

  Widget _reminderDescription(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          'Купить: Картофель, Морковь, Лук, Чеснок, Петрушка, Укроп, Яблоки.',
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
        ),
      );

  Widget _editButton(BuildContext context) => SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Text('Edit'),
          onPressed: () {
            Navigator.of(context).pop();
            EditReminderDialog.open(context, reminderId: reminderId);
          },
        ),
      );
}
