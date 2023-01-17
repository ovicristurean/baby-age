import 'package:equatable/equatable.dart';

abstract class BabyCalendarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStartDate extends BabyCalendarEvent {}

class UpdateStartDate extends BabyCalendarEvent {
  final DateTime newStartDate;

  UpdateStartDate({required this.newStartDate});

  @override
  List<Object> get props => [newStartDate];
}

class UpdateSelectedDate extends BabyCalendarEvent {
  final DateTime startDate;
  final DateTime newSelectedDate;
  final DateTime endDate;

  UpdateSelectedDate({required this.newSelectedDate, required this.startDate, required this.endDate});

  @override
  List<Object> get props => [newSelectedDate];
}
