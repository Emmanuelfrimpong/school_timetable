// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassesModelAdapter extends TypeAdapter<ClassesModel> {
  @override
  final int typeId = 0;

  @override
  ClassesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassesModel(
      id: fields[0] as String?,
      className: fields[1] as String?,
      courses: fields[2] as String?,
      subjects: (fields[3] as List?)?.cast<dynamic>(),
      createdAt: fields[4] as int?,
      classCode: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ClassesModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.className)
      ..writeByte(2)
      ..write(obj.courses)
      ..writeByte(3)
      ..write(obj.subjects)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.classCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
