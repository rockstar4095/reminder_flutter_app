import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main/main_bloc.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/screens/mainscreen/view_reminder_dialog.dart';
import 'package:reminder_flutter_app/utils/extensions.dart';

class ReminderItem extends StatelessWidget {
  final List<Reminder> reminders;
  final int index;
  final Reminder _current;
  final Reminder _previous;
  final int reminderId;

  ReminderItem({
    @required this.reminders,
    @required this.index,
  })  : _current = reminders[index],
        _previous = index > 0 ? reminders[index - 1] : null,
        reminderId = reminders[index].id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isFirstItem()) SizedBox(height: 16),
        if (isDateDividerNeeded()) _dateDivider(context),
        _item(context),
        if (_isLastItem()) SizedBox(height: 80),
      ],
    );
  }

  bool _isFirstItem() => index == 0;

  bool _isLastItem() => index == reminders.length - 1;

  bool isDateDividerNeeded() =>
      index == 0 || _previous.dateTime.isNotSameDate(_current.dateTime);

  Widget _item(BuildContext context) => BlocBuilder<MainBloc, MainState>(
        buildWhen: (previous, current) =>
            previous.quantityOfSelectedItems !=
                current.quantityOfSelectedItems ||
            previous.isSelectedModeActive != current.isSelectedModeActive,
        builder: (context, state) {
          return InkWell(
            splashColor: Theme.of(context).primaryColor,
            highlightColor: Theme.of(context).primaryColorLight,
            onTap: () {
              if (state.isSelectedModeActive) {
                context.read<MainBloc>().onItemSelect(reminderId);
              } else {
                ViewReminderDialog.open(context, reminderId);
              }
            },
            onLongPress: () =>
                context.read<MainBloc>().onItemSelect(reminderId),
            child: _itemContent(context),
          );
        },
      );

  Widget _itemContent(BuildContext context) => Container(
        color: _current.isSelected
            ? Theme.of(context).primaryColorLight
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _reminderContent(context)),
                  Text(_current.dateTime.hhmm()),
                ],
              ),
              if (_current.description.isNotEmpty)
                _reminderDescription(context),
            ],
          ),
        ),
      );

  Widget _reminderContent(BuildContext context) => Text(
        _current.title,
        style: Theme.of(context).textTheme.bodyText1,
      );

  Widget _dateDivider(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 16, bottom: 4),
        child: Text(
          _current.dateTime.ddMMyy(),
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
        ),
      );

  Widget _reminderDescription(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: _current.description,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      );
}
