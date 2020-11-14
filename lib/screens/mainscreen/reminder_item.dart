import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_bloc.dart';
import 'package:reminder_flutter_app/model/reminder.dart';
import 'package:reminder_flutter_app/utils/extensions.dart';

class ReminderItem extends StatelessWidget {
  final List<Reminder> reminders;
  final int index;
  final Reminder _current;
  final Reminder _previous;

  ReminderItem({
    @required this.reminders,
    @required this.index,
  })  : _current = reminders[index],
        _previous = index > 0 ? reminders[index - 1] : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDateDividerNeeded()) _dateDivider(context),
        _item(context),
      ],
    );
  }

  bool isDateDividerNeeded() =>
      index == 0 || _previous.dateTime.isNotSameDate(_current.dateTime);

  Widget _item(BuildContext context) => BlocBuilder<MainBloc, MainState>(
        buildWhen: (previous, current) =>
            previous.selectedIndexes != current.selectedIndexes,
        builder: (context, state) => InkWell(
          onTap: () {
            if (state.isSelectedModeActive) {
              context.read<MainBloc>().onItemSelect(index);
            } else {
              // open reminder summary
            }
          },
          onLongPress: () => context.read<MainBloc>().onItemSelect(index),
          child: _itemContent(context, state),
        ),
      );

  Widget _itemContent(BuildContext context, MainState state) => Container(
        color: state.selectedIndexes.contains(index)
            ? Colors.grey
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _reminderContent(context),
                  ),
                  Text(_current.dateTime.hhmm()),
                ],
              ),
              if (_current.description.isNotEmpty) _reminderDescription(context)
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          _current.dateTime.ddMMyy(),
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
        ),
      );

  Widget _reminderDescription(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: _current.description,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
      );
}
