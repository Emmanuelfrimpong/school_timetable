// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'table_model.g.dart';

@HiveType(typeId: 2)
class TableModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? className;
  @HiveField(2)
  String? programme;
  @HiveField(3)
  String? subject;
  @HiveField(4)
  String? teacherId;
  @HiveField(5)
  String? teacherName;
  @HiveField(6)
  String? classId;
  @HiveField(7)
  String? classCode;
  @HiveField(8)
  String? day;
  @HiveField(9)
  int? period;
  @HiveField(10)
  Map<String,dynamic>? periodMap;
  @HiveField(11)
  int? createdAt;
  TableModel({
    this.id,
    this.className,
    this.programme,
    this.subject,
    this.teacherId,
    this.teacherName,
    this.classId,
    this.classCode,
    this.day,
    this.period,
    this.periodMap,
    this.createdAt,
  });
  

  TableModel copyWith({
    String? id,
    String? className,
    String? programme,
    String? subject,
    String? teacherId,
    String? teacherName,
    String? classId,
    String? classCode,
    String? day,
    int? period,
    Map<String,dynamic>? periodMap,
    int? createdAt,
  }) {
    return TableModel(
      id: id ?? this.id,
      className: className ?? this.className,
      programme: programme ?? this.programme,
      subject: subject ?? this.subject,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      classId: classId ?? this.classId,
      classCode: classCode ?? this.classCode,
      day: day ?? this.day,
      period: period ?? this.period,
      periodMap: periodMap ?? this.periodMap,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'className': className,
      'programme': programme,
      'subject': subject,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'classId': classId,
      'classCode': classCode,
      'day': day,
      'period': period,
      'periodMap': periodMap,
      'createdAt': createdAt,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'] != null ? map['id'] as String : null,
      className: map['className'] != null ? map['className'] as String : null,
      programme: map['programme'] != null ? map['programme'] as String : null,
      subject: map['subject'] != null ? map['subject'] as String : null,
      teacherId: map['teacherId'] != null ? map['teacherId'] as String : null,
      teacherName: map['teacherName'] != null ? map['teacherName'] as String : null,
      classId: map['classId'] != null ? map['classId'] as String : null,
      classCode: map['classCode'] != null ? map['classCode'] as String : null,
      day: map['day'] != null ? map['day'] as String : null,
      period: map['period'] != null ? map['period'] as int : null,
      periodMap: map['periodMap'] != null ? Map<String,dynamic>.from((map['periodMap'] as Map<String,dynamic>)) : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) => TableModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TableModel(id: $id, className: $className, programme: $programme, subject: $subject, teacherId: $teacherId, teacherName: $teacherName, classId: $classId, classCode: $classCode, day: $day, period: $period, periodMap: $periodMap, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TableModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.className == className &&
      other.programme == programme &&
      other.subject == subject &&
      other.teacherId == teacherId &&
      other.teacherName == teacherName &&
      other.classId == classId &&
      other.classCode == classCode &&
      other.day == day &&
      other.period == period &&
      mapEquals(other.periodMap, periodMap) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      className.hashCode ^
      programme.hashCode ^
      subject.hashCode ^
      teacherId.hashCode ^
      teacherName.hashCode ^
      classId.hashCode ^
      classCode.hashCode ^
      day.hashCode ^
      period.hashCode ^
      periodMap.hashCode ^
      createdAt.hashCode;
  }
}
