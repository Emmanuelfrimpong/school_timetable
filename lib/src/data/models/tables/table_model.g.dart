// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableModelAdapter extends TypeAdapter<TableModel> {
  @override
  final int typeId = 2;

  @override
  TableModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableModel(
      id: fields[0] as String?,
      className: fields[1] as String?,
      programme: fields[2] as String?,
      subject: fields[3] as String?,
      teacherId: fields[4] as String?,
      teacherName: fields[5] as String?,
      classId: fields[6] as String?,
      classCode: fields[7] as String?,
      day: fields[8] as String?,
      period: fields[9] as int?,
      periodMap: (fields[10] as Map?)?.cast<String, dynamic>(),
      createdAt: fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TableModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.className)
      ..writeByte(2)
      ..write(obj.programme)
      ..writeByte(3)
      ..write(obj.subject)
      ..writeByte(4)
      ..write(obj.teacherId)
      ..writeByte(5)
      ..write(obj.teacherName)
      ..writeByte(6)
      ..write(obj.classId)
      ..writeByte(7)
      ..write(obj.classCode)
      ..writeByte(8)
      ..write(obj.day)
      ..writeByte(9)
      ..write(obj.period)
      ..writeByte(10)
      ..write(obj.periodMap)
      ..writeByte(11)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
