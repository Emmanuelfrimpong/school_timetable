// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeriodModelAdapter extends TypeAdapter<PeriodModel> {
  @override
  final int typeId = 3;

  @override
  PeriodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeriodModel(
      period: fields[0] as int?,
      periodName: fields[1] as String?,
      startTime: fields[2] as String?,
      endTime: fields[3] as String?,
      periodId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PeriodModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.period)
      ..writeByte(1)
      ..write(obj.periodName)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.periodId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
