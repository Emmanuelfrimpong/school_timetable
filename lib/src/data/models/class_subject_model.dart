// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassSubjectModel {
   String? subjectName;
   String? subjectCode;
   String? classCode;
   String? className;
   String? classId;
  ClassSubjectModel({
    this.subjectName,
    this.subjectCode,
    this.classCode,
    this.className,
    this.classId,
  });

  ClassSubjectModel copyWith({
    String? subjectName,
    String? subjectCode,
    String? classCode,
    String? className,
    String? classId,
  }) {
    return ClassSubjectModel(
      subjectName: subjectName ?? this.subjectName,
      subjectCode: subjectCode ?? this.subjectCode,
      classCode: classCode ?? this.classCode,
      className: className ?? this.className,
      classId: classId ?? this.classId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectName': subjectName,
      'subjectCode': subjectCode,
      'classCode': classCode,
      'className': className,
      'classId': classId,
    };
  }

  factory ClassSubjectModel.fromMap(Map<String, dynamic> map) {
    return ClassSubjectModel(
      subjectName: map['subjectName'] != null ? map['subjectName'] as String : null,
      subjectCode: map['subjectCode'] != null ? map['subjectCode'] as String : null,
      classCode: map['classCode'] != null ? map['classCode'] as String : null,
      className: map['className'] != null ? map['className'] as String : null,
      classId: map['classId'] != null ? map['classId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassSubjectModel.fromJson(String source) => ClassSubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassSubjectModel(subjectName: $subjectName, subjectCode: $subjectCode, classCode: $classCode, className: $className, classId: $classId)';
  }

  @override
  bool operator ==(covariant ClassSubjectModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.subjectName == subjectName &&
      other.subjectCode == subjectCode &&
      other.classCode == classCode &&
      other.className == className &&
      other.classId == classId;
  }

  @override
  int get hashCode {
    return subjectName.hashCode ^
      subjectCode.hashCode ^
      classCode.hashCode ^
      className.hashCode ^
      classId.hashCode;
  }
}
