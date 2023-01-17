import 'package:baby_age/presentation/baby_calendar_screen/viewdata/pregnancy_progress.dart';
import 'package:equatable/equatable.dart';

abstract class BabyCalendarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends BabyCalendarState {}

class StartDateFetched extends BabyCalendarState {
  final DateTime startDay;
  final DateTime currentDay;
  final DateTime lastDay;
  final Duration progress;
  final PregnancyProgress pregnancyProgress;

  @override
  List<Object?> get props => [
        startDay,
        currentDay,
        lastDay,
        progress,
        pregnancyProgress,
      ];

  StartDateFetched({
    required this.startDay,
    required this.currentDay,
    required this.lastDay,
    required this.progress,
    required this.pregnancyProgress,
  });
}
