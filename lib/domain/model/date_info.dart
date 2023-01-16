import 'dart:convert';

import 'package:equatable/equatable.dart';

class DateInfo extends Equatable {
  final int year;
  final int month;
  final int day;

  @override
  List<Object?> get props => [year, month, day];

  const DateInfo(this.year, this.month, this.day);

  Map<String, dynamic> toJson() => {'year': year, 'month': month, 'day': day};

  String toJsonString() {
    return jsonEncode(this);
  }

  static DateInfo fromJson(String? json) {
    return json != null
        ? DateInfo.fromMap(jsonDecode(json) as Map<String, dynamic>)
        : DateInfo(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  Map<String, dynamic> toMap() {
    return {
      'year': this.year,
      'month': this.month,
      'day': this.day,
    };
  }

  factory DateInfo.fromMap(Map<String, dynamic> map) {
    return DateInfo(
      map['year'] as int,
      map['month'] as int,
      map['day'] as int,
    );
  }
}
