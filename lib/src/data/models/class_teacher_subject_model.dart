import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClassTecherSubjectModel {
  String? subjectName;
   String? subjectCode;
   String? classCode;
   String? className;
   String? classId;
  String? teacherName;
  String? teacherId; 
  ClassTecherSubjectModel({
    this.subjectName,
    this.subjectCode,
    this.classCode,
    this.className,
    this.classId,
    this.teacherName,
    this.teacherId,
  });

  ClassTecherSubjectModel copyWith({
    String? subjectName,
    String? subjectCode,
    String? classCode,
    String? className,
    String? classId,
    String? teacherName,
    String? teacherId,
  }) {
    return ClassTecherSubjectModel(
      subjectName: subjectName ?? this.subjectName,
      subjectCode: subjectCode ?? this.subjectCode,
      classCode: classCode ?? this.classCode,
      className: className ?? this.className,
      classId: classId ?? this.classId,
      teacherName: teacherName ?? this.teacherName,
      teacherId: teacherId ?? this.teacherId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectName': subjectName,
      'subjectCode': subjectCode,
      'classCode': classCode,
      'className': className,
      'classId': classId,
      'teacherName': teacherName,
      'teacherId': teacherId,
    };
  }

  factory ClassTecherSubjectModel.fromMap(Map<String, dynamic> map) {
    return ClassTecherSubjectModel(
      subjectName: map['subjectName'] != null ? map['subjectName'] as String : null,
      subjectCode: map['subjectCode'] != null ? map['subjectCode'] as String : null,
      classCode: map['classCode'] != null ? map['classCode'] as String : null,
      className: map['className'] != null ? map['className'] as String : null,
      classId: map['classId'] != null ? map['classId'] as String : null,
      teacherName: map['teacherName'] != null ? map['teacherName'] as String : null,
      teacherId: map['teacherId'] != null ? map['teacherId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassTecherSubjectModel.fromJson(String source) => ClassTecherSubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassTecherSubjectModel(subjectName: $subjectName, subjectCode: $subjectCode, classCode: $classCode, className: $className, classId: $classId, teacherName: $teacherName, teacherId: $teacherId)';
  }

  @override
  bool operator ==(covariant ClassTecherSubjectModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.subjectName == subjectName &&
      other.subjectCode == subjectCode &&
      other.classCode == classCode &&
      other.className == className &&
      other.classId == classId &&
      other.teacherName == teacherName &&
      other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    return subjectName.hashCode ^
      subjectCode.hashCode ^
      classCode.hashCode ^
      className.hashCode ^
      classId.hashCode ^
      teacherName.hashCode ^
      teacherId.hashCode;
  }
}
