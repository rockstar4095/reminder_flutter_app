// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderEntityAdapter extends TypeAdapter<ReminderEntity> {
  @override
  final int typeId = 0;

  @override
  ReminderEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderEntity(
      index: fields[0] as int,
      title: fields[1] as String,
      dateTime: fields[3] as DateTime,
      description: fields[2] as String,
      isShoppingReminder: fields[4] as bool,
      products: (fields[5] as List)?.cast<ProductEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReminderEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.isShoppingReminder)
      ..writeByte(5)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
