// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'teacher_model.g.dart';

@HiveType(typeId: 1)
class TeacherModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? subject;
  @HiveField(3)
  List<dynamic>? classesName;
  @HiveField(4)
   List<dynamic>? classesCode;
  @HiveField(5)
  int? createdAt;  
  TeacherModel({
    this.id,
    this.name,
    this.subject,
    this.classesName,
    this.classesCode,
    this.createdAt,
  });

  TeacherModel copyWith({
    String? id,
    String? name,
    String? subject,
    List<dynamic>? classesName,
    List<dynamic>? classesCode,
    int? createdAt,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      classesName: classesName ?? this.classesName,
      classesCode: classesCode ?? this.classesCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'subject': subject,
      'classesName': classesName,
      'classesCode': classesCode,
      'createdAt': createdAt,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      subject: map['subject'] != null ? map['subject'] as String : null,
      classesName: map['classesName'] != null ? List<dynamic>.from((map['classesName'] as List<dynamic>)) : null,
      classesCode: map['classesCode'] != null ? List<dynamic>.from((map['classesCode'] as List<dynamic>)) : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) => TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherModel(id: $id, name: $name, subject: $subject, classesName: $classesName, classesCode: $classesCode, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TeacherModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.subject == subject &&
      listEquals(other.classesName, classesName) &&
      listEquals(other.classesCode, classesCode) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      subject.hashCode ^
      classesName.hashCode ^
      classesCode.hashCode ^
      createdAt.hashCode;
  }
}
