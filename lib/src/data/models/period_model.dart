// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'period_model.g.dart';
@HiveType(typeId: 3)
class PeriodModel {
  @HiveField(0)
  int? period;
  @HiveField(1)
  String? periodName;
  @HiveField(2)
  String? startTime;
  @HiveField(3)
  String? endTime;
  @HiveField(4)
  String? periodId;
  PeriodModel({
    this.period,
    this.periodName,
    this.startTime,
    this.endTime,
    this.periodId,
  });
 

  PeriodModel copyWith({
    int? period,
    String? periodName,
    String? startTime,
    String? endTime,
    String? periodId,
  }) {
    return PeriodModel(
      period: period ?? this.period,
      periodName: periodName ?? this.periodName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      periodId: periodId ?? this.periodId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'period': period,
      'periodName': periodName,
      'startTime': startTime,
      'endTime': endTime,
      'periodId': periodId,
    };
  }

  factory PeriodModel.fromMap(Map<String, dynamic> map) {
    return PeriodModel(
      period: map['period'] != null ? map['period'] as int : null,
      periodName: map['periodName'] != null ? map['periodName'] as String : null,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      periodId: map['periodId'] != null ? map['periodId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PeriodModel.fromJson(String source) => PeriodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PeriodModel(period: $period, periodName: $periodName, startTime: $startTime, endTime: $endTime, periodId: $periodId)';
  }

  @override
  bool operator ==(covariant PeriodModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.period == period &&
      other.periodName == periodName &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.periodId == periodId;
  }

  @override
  int get hashCode {
    return period.hashCode ^
      periodName.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      periodId.hashCode;
  }
}
