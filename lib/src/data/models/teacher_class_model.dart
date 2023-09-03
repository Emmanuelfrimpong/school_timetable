// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TeacherClassModel {
  String? id;
  String? teacherName;
  String? classCode;
  String? subjectName;
  String? teacherId;
  TeacherClassModel({
    this.id,
    this.teacherName,
    this.classCode,
    this.subjectName,
    this.teacherId,
  });

  TeacherClassModel copyWith({
    String? id,
    String? teacherName,
    String? classCode,
    String? subjectName,
    String? teacherId,
  }) {
    return TeacherClassModel(
      id: id ?? this.id,
      teacherName: teacherName ?? this.teacherName,
      classCode: classCode ?? this.classCode,
      subjectName: subjectName ?? this.subjectName,
      teacherId: teacherId ?? this.teacherId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'teacherName': teacherName,
      'classCode': classCode,
      'subjectName': subjectName,
      'teacherId': teacherId,
    };
  }

  factory TeacherClassModel.fromMap(Map<String, dynamic> map) {
    return TeacherClassModel(
      id: map['id'] != null ? map['id'] as String : null,
      teacherName: map['teacherName'] != null ? map['teacherName'] as String : null,
      classCode: map['classCode'] != null ? map['classCode'] as String : null,
      subjectName: map['subjectName'] != null ? map['subjectName'] as String : null,
      teacherId: map['teacherId'] != null ? map['teacherId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherClassModel.fromJson(String source) => TeacherClassModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherClassModel(id: $id, teacherName: $teacherName, classCode: $classCode, subjectName: $subjectName, teacherId: $teacherId)';
  }

  @override
  bool operator ==(covariant TeacherClassModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.teacherName == teacherName &&
      other.classCode == classCode &&
      other.subjectName == subjectName &&
      other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      teacherName.hashCode ^
      classCode.hashCode ^
      subjectName.hashCode ^
      teacherId.hashCode;
  }
}
