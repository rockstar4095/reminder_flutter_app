part of 'view_reminder_bloc.dart';

abstract class ViewReminderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReminderLoaded extends ViewReminderEvent {
  final Reminder reminder;

  ReminderLoaded({@required this.reminder}) : assert(reminder != null);

  @override
  List<Object> get props => [reminder];
}

class ReminderOpened extends ViewReminderEvent {
  final int reminderId;

  ReminderOpened({@required this.reminderId});

  @override
  List<Object> get props => [reminderId];
}

class OpenedReminderLoaded extends ViewReminderEvent {
  final Reminder reminder;

  OpenedReminderLoaded({@required this.reminder}) : assert(reminder != null);

  @override
  List<Object> get props => [reminder];
}

class ProductCheckChanged extends ViewReminderEvent {
  final Reminder reminder;
  final Product product;

  ProductCheckChanged({
    @required this.product,
    @required this.reminder,
  })  : assert(product != null),
        assert(reminder != null);

  @override
  List<Object> get props => [
        product,
        reminder,
      ];
}

class DialogClosed extends ViewReminderEvent {}
