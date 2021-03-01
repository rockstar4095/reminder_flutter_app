import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/viewreminder/view_reminder_bloc.dart';
import 'package:reminder_flutter_app/generated/l10n.dart';
import 'package:reminder_flutter_app/model/product.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
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
    ).then((_) => context.read<ViewReminderBloc>().add(DialogClosed()));
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
        builder: (context, state) {
          final String date = state.reminder.dateTime.ddMMyy();
          final String time = state.reminder.dateTime.hhmm();

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
        builder: (context, state) => Align(
          child: Text(
            state.reminder.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      );

  Widget _description(BuildContext context) =>
      BlocBuilder<ViewReminderBloc, ViewReminderState>(
        builder: (context, state) {
          if (state.reminder.description.isEmpty) return SizedBox();
          return state.reminder.isShoppingReminder
              ? _shoppingDescription(context)
              : _regularDescription(context);
        },
      );

  Widget _regularDescription(BuildContext context) {
    return BlocBuilder<ViewReminderBloc, ViewReminderState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 24),
        child: Text(
          state.reminder.description,
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
        ),
      ),
    );
  }

  Widget _shoppingDescription(BuildContext context) {
    return BlocBuilder<ViewReminderBloc, ViewReminderState>(
      builder: (context, state) {
        final reminder = state.reminder;
        final List<Product> productsList =
            reminder.products.toList(growable: false);

        return ListView.builder(
            shrinkWrap: true,
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  _CheckBox(reminder: reminder, product: productsList[index]),
                  Text(productsList[index].name),
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

class _CheckBox extends StatelessWidget {
  final Reminder reminder;
  final Product product;

  const _CheckBox({
    @required this.product,
    @required this.reminder,
  })  : assert(product != null),
        assert(reminder != null);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: product.isChecked,
        onChanged: product.isChecked
            ? null
            : (newValue) {
                context.read<ViewReminderBloc>().add(ProductCheckChanged(
                      reminder: reminder,
                      product: product.copyWith(isChecked: newValue),
                    ));
              });
  }
}
