import 'dart:convert';

import 'package:equatable/equatable.dart';

class DateInfo extends Equatable {
  final int year;
  final int month;
  final int day;

  @override
  List<Object?> get props => [year, month, day];

  const DateInfo({required this.year, required this.month, required this.day});

  Map<String, dynamic> toJson() => {'year': year, 'month': month, 'day': day};

  String toJsonString() {
    return jsonEncode(this);
  }

  static DateInfo fromJson(String? json) {
    return json != null
        ? DateInfo.fromMap(jsonDecode(json) as Map<String, dynamic>)
        : DateInfo(
            year: DateTime.now().year,
            month: DateTime.now().month,
            day: DateTime.now().day,
          );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': this.year,
      'month': this.month,
      'day': this.day,
    };
  }

  DateTime toDateTime() => DateTime(year, month, day);

  factory DateInfo.fromMap(Map<String, dynamic> map) {
    return DateInfo(
      year: map['year'] as int,
      month: map['month'] as int,
      day: map['day'] as int,
    );
  }
}
