import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/viewreminder/view_reminder_bloc.dart';
import 'package:reminder_flutter_app/generated/l10n.dart';
import 'package:reminder_flutter_app/screens/mainscreen/edit_reminder_dialog.dart';
import 'package:reminder_flutter_app/utils/extensions.dart';
import 'package:reminder_flutter_app/utils/widgets.dart';
import 'package:reminder_flutter_app/widget/buttons.dart';

class ViewReminderDialog {
  static void open(BuildContext context, int reminderId) {
    context.read<ViewReminderBloc>().add(
          ReminderOpened(reminderId: reminderId),
        );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ViewReminderDialog(reminderId),
    );
  }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _dateTime(context),
                _closeDialogButton(context),
              ],
            ),
            SizedBox(height: 24),
            _title(context),
            SizedBox(height: 16),
            _description(context),
            _editButton(context),
            SizedBox(height: 16),
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

  Widget _dateTime(BuildContext context) =>
      BlocBuilder<ViewReminderBloc, ViewReminderState>(
        buildWhen: (previous, current) =>
            previous.openedDateTime != current.openedDateTime,
        builder: (context, state) {
          final String date = state.openedDateTime.ddMMyy();
          final String time = state.openedDateTime.hhmm();

          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                S.of(context).onDateInTime(date, time),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          );
        },
      );

  Widget _title(BuildContext context) =>
      BlocBuilder<ViewReminderBloc, ViewReminderState>(
        buildWhen: (previous, current) =>
            previous.openedTitle != current.openedTitle,
        builder: (context, state) => Align(
          child: Text(
            state.openedTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      );

  Widget _description(BuildContext context) =>
      BlocBuilder<ViewReminderBloc, ViewReminderState>(
        buildWhen: (previous, current) =>
            previous.openedDescription != current.openedDescription,
        builder: (context, state) {
          if (state.openedDescription.isEmpty) return SizedBox();
          return state.openedIsShoppingReminder
              ? _shoppingDescription(context)
              : _regularDescription(context);
        },
      );

  Widget _regularDescription(BuildContext context) {
    return BlocBuilder<ViewReminderBloc, ViewReminderState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 24),
        child: Text(
          state.openedDescription,
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
        ),
      ),
    );
  }

  Widget _shoppingDescription(BuildContext context) {
    return BlocBuilder<ViewReminderBloc, ViewReminderState>(
      builder: (context, state) {
        final List<String> productsList = state.openedDescription.split(',')
          ..forEach((element) {
            element.trim();
          });

        return ListView.builder(
            shrinkWrap: true,
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  _CheckBox(),
                  Text(productsList[index]),
                ],
              );
            });
      },
    );
  }

  Widget _editButton(BuildContext context) => SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          text: S.of(context).editButton,
          onPressed: () {
            Navigator.of(context).pop();
            EditReminderDialog.open(context, reminderId: reminderId);
          },
        ),
      );
}

class _CheckBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<_CheckBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: _isChecked,
        onChanged: (newValue) {
          setState(() {
            _isChecked = newValue;
          });
        });
  }
}
