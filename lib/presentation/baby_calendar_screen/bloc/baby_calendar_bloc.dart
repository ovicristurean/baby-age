import 'package:baby_age/data/user_preferences_data_source.dart';
import 'package:baby_age/domain/model/date_info.dart';
import 'package:baby_age/presentation/baby_calendar_screen/bloc/baby_calendar_event.dart';
import 'package:baby_age/presentation/baby_calendar_screen/bloc/baby_calendar_state.dart';
import 'package:baby_age/presentation/baby_calendar_screen/viewdata/pregnancy_progress.dart';
import 'package:baby_age/presentation/utils/date_time_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BabyCalendarBloc extends Bloc<BabyCalendarEvent, BabyCalendarState> {
  final UserPreferencesDataSource userPreferencesDataSource;

  BabyCalendarBloc(super.initialState, this.userPreferencesDataSource) {
    on<LoadStartDate>((event, emit) async {
      await userPreferencesDataSource.getStoredStartDate().then((startDate) {
        var progressDuration =
            DateTime.now().difference(startDate.toDateTime());

        emit(StartDateFetched(
          startDay: startDate.toDateTime(),
          currentDay: DateTime.now(),
          lastDay: startDate.toDateTime().add(const Duration(days: 280)),
          progress: progressDuration,
          pregnancyProgress: PregnancyProgress(
            weeks: progressDuration.inDays ~/ 7,
            days: progressDuration.inDays % 7,
            totalNumberOfDays: progressDuration.inDays,
            trimester:
                DateTimeMapper.getTrimesterForProgress(progressDuration.inDays),
          ),
        ));
      });
    });

    on<UpdateStartDate>((event, emit) async {
      bool wasSaveSuccess =
          await userPreferencesDataSource.saveStartDate(DateInfo(
        year: event.newStartDate.year,
        month: event.newStartDate.month,
        day: event.newStartDate.day,
      ));
      var progressDuration = DateTime.now().difference(event.newStartDate);
      if (wasSaveSuccess) {
        emit(StartDateFetched(
          startDay: event.newStartDate,
          currentDay: DateTime.now(),
          lastDay: event.newStartDate.add(const Duration(days: 280)),
          progress: DateTime.now().difference(event.newStartDate),
          pregnancyProgress: PregnancyProgress(
            weeks: progressDuration.inDays ~/ 7,
            days: progressDuration.inDays % 7,
            totalNumberOfDays: progressDuration.inDays,
            trimester:
                DateTimeMapper.getTrimesterForProgress(progressDuration.inDays),
          ),
        ));
      }
    });

    on<UpdateSelectedDate>((event, emit) async {
      var progressDuration = event.newSelectedDate.difference(event.startDate);
      emit(StartDateFetched(
        startDay: event.startDate,
        currentDay: event.newSelectedDate,
        lastDay: event.endDate,
        progress: event.newSelectedDate.difference(event.startDate),
        pregnancyProgress: PregnancyProgress(
          weeks: progressDuration.inDays ~/ 7,
          days: progressDuration.inDays % 7,
          totalNumberOfDays: progressDuration.inDays,
          trimester:
              DateTimeMapper.getTrimesterForProgress(progressDuration.inDays),
        ),
      ));
    });
  }
}
