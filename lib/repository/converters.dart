import 'package:reminder_flutter_app/entity/product_entity.dart';
import 'package:reminder_flutter_app/entity/reminder_entity.dart';
import 'package:reminder_flutter_app/model/product.dart';
import 'package:reminder_flutter_app/model/reminder.dart';

extension ReminderToReminderEntity on Reminder {
  ReminderEntity toReminderEntity() {
    if (this == null) return null;
    return ReminderEntity(
      index: id,
      title: title,
      description: description,
      dateTime: dateTime,
      isShoppingReminder: isShoppingReminder,
      products:
          products?.map((e) => e.toProductEntity())?.toList(growable: false) ??
              [],
    );
  }
}

extension RemindersToReminderEntitites on List<Reminder> {
  List<ReminderEntity> toReminderEntitiesList() {
    if (this == null) return [];
    return List.generate(
      length,
      (index) => this[index].toReminderEntity(),
    );
  }
}

extension ReminderEntityToReminder on ReminderEntity {
  Reminder toReminder() {
    if (this == null) return null;
    return Reminder(
      id: index,
      title: title,
      description: description,
      dateTime: dateTime,
      isShoppingReminder: isShoppingReminder,
      products:
          products?.map((e) => e.toProduct())?.toList(growable: false) ?? [],
    );
  }
}

extension ReminderEnititesToRemonders on List<ReminderEntity> {
  List<Reminder> toRemindersList() {
    if (this == null) return [];
    return List.generate(
      length,
      (index) => this[index].toReminder(),
    );
  }
}

extension on Product {
  ProductEntity toProductEntity() => ProductEntity(
        name: name,
        isChecked: isChecked,
      );
}

extension on ProductEntity {
  Product toProduct() => Product(
        name: name,
        isChecked: isChecked,
      );
}
