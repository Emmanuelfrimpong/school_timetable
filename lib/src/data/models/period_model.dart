// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PeriodModel {
  int? period;
  String? periodName;
  String? startTime;
  String? endTime;
  PeriodModel({
    this.period,
    this.periodName,
    this.startTime,
    this.endTime,
  });

  PeriodModel copyWith({
    int? period,
    String? periodName,
    String? startTime,
    String? endTime,
  }) {
    return PeriodModel(
      period: period ?? this.period,
      periodName: periodName ?? this.periodName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'period': period,
      'periodName': periodName,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory PeriodModel.fromMap(Map<String, dynamic> map) {
    return PeriodModel(
      period: map['period'] != null ? map['period'] as int : null,
      periodName: map['periodName'] != null ? map['periodName'] as String : null,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PeriodModel.fromJson(String source) => PeriodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PeriodModel(period: $period, periodName: $periodName, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(covariant PeriodModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.period == period &&
      other.periodName == periodName &&
      other.startTime == startTime &&
      other.endTime == endTime;
  }

  @override
  int get hashCode {
    return period.hashCode ^
      periodName.hashCode ^
      startTime.hashCode ^
      endTime.hashCode;
  }
}
