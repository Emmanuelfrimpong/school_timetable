// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

part 'classes_model.g.dart';

@HiveType(typeId: 0)
class ClassesModel {
   @HiveField(0)
  String? id;
  @HiveField(1)
  String? className;
  @HiveField(2)
  String? courses;
  @HiveField(3)
  List<dynamic>? subjects;
  @HiveField(4)
  int? createdAt;
  @HiveField(5)
  String? classCode;
  ClassesModel({
    this.id,
    this.className,
    this.courses,
    this.subjects,
    this.createdAt,
    this.classCode,
  });

  ClassesModel copyWith({
    String? id,
    String? className,
    String? courses,
    List<dynamic>? subjects,
    int? createdAt,
    String? classCode,
  }) {
    return ClassesModel(
      id: id ?? this.id,
      className: className ?? this.className,
      courses: courses ?? this.courses,
      subjects: subjects ?? this.subjects,
      createdAt: createdAt ?? this.createdAt,
      classCode: classCode ?? this.classCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'className': className,
      'courses': courses,
      'subjects': subjects,
      'createdAt': createdAt,
      'classCode': classCode,
    };
  }

  factory ClassesModel.fromMap(Map<String, dynamic> map) {
    return ClassesModel(
      id: map['id'] != null ? map['id'] as String : null,
      className: map['className'] != null ? map['className'] as String : null,
      courses: map['courses'] != null ? map['courses'] as String : null,
      subjects: map['subjects'] != null ? List<dynamic>.from((map['subjects'] as List<dynamic>)) : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
      classCode: map['classCode'] != null ? map['classCode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassesModel.fromJson(String source) => ClassesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassesModel(id: $id, className: $className, courses: $courses, subjects: $subjects, createdAt: $createdAt, classCode: $classCode)';
  }

  @override
  bool operator ==(covariant ClassesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.className == className &&
      other.courses == courses &&
      listEquals(other.subjects, subjects) &&
      other.createdAt == createdAt &&
      other.classCode == classCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      className.hashCode ^
      courses.hashCode ^
      subjects.hashCode ^
      createdAt.hashCode ^
      classCode.hashCode;
  }
}
