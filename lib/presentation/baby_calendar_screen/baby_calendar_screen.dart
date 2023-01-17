import 'package:baby_age/data/user_preferences_repository.dart';
import 'package:baby_age/presentation/baby_calendar_screen/bloc/baby_calendar_bloc.dart';
import 'package:baby_age/presentation/baby_calendar_screen/bloc/baby_calendar_event.dart';
import 'package:baby_age/presentation/baby_calendar_screen/bloc/baby_calendar_state.dart';
import 'package:baby_age/presentation/baby_calendar_screen/viewdata/pregnancy_progress.dart';
import 'package:baby_age/presentation/baby_calendar_screen/widget/date_selector.dart';
import 'package:baby_age/presentation/utils/date_time_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class BabyCalendarScreen extends StatefulWidget {
  final Color? screenBackground;

  const BabyCalendarScreen({Key? key, required this.screenBackground})
      : super(key: key);

  @override
  State<BabyCalendarScreen> createState() => _BabyCalendarScreenState();
}

class _BabyCalendarScreenState extends State<BabyCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) => UserPreferencesRepository(),
      child: BlocProvider(
        create: (BuildContext context) => BabyCalendarBloc(
            LoadingState(), context.read<UserPreferencesRepository>())
          ..add(LoadStartDate()),
        child: Container(
          color: widget.screenBackground,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<BabyCalendarBloc, BabyCalendarState>(
              builder: (BuildContext context, BabyCalendarState state) {
                var focusedDay = DateTime.now();
                switch (state.runtimeType) {
                  case LoadingState:
                    {
                      return const Center(child: Text("Loading data"));
                    }

                  case StartDateFetched:
                    {
                      StartDateFetched startDateFetchedState =
                          state as StartDateFetched;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SelectedDateView(
                              startDate: startDateFetchedState.startDay,
                              endDate: startDateFetchedState.startDay
                                  .add(const Duration(days: 280)),
                              onStartDateChanged: (newDate) {
                                focusedDay = DateTime.now();
                                BlocProvider.of<BabyCalendarBloc>(context).add(
                                    UpdateStartDate(newStartDate: newDate));
                              }),
                          Text(
                            "Current pregnancy status: ${startDateFetchedState.pregnancyProgress.weeks} weeks, and ${startDateFetchedState.pregnancyProgress.days} days",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Trimester ${startDateFetchedState.pregnancyProgress.trimester.number} ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TableCalendar(
                            firstDay: startDateFetchedState.startDay,
                            lastDay: startDateFetchedState.lastDay,
                            focusedDay: focusedDay,
                            selectedDayPredicate: (day) => isSameDay(
                                startDateFetchedState.currentDay, day),
                            onDaySelected: (selected, focused) {
                              focusedDay = focused;
                              BlocProvider.of<BabyCalendarBloc>(context)
                                  .add(UpdateSelectedDate(
                                startDate: startDateFetchedState.startDay,
                                newSelectedDate: selected,
                                endDate: startDateFetchedState.lastDay,
                              ));
                            },
                            onPageChanged: (focused) {
                              focusedDay = focused;
                            },
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, focusedDay) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getCellColor(DateTimeMapper
                                          .getTrimesterForProgress(day
                                              .difference(startDateFetchedState
                                                  .startDay)
                                              .inDays)),
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                        Center(child: Text(day.day.toString())),
                                  ),
                                );
                              },
                            ),
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month'
                            },
                          )
                        ],
                      );
                    }
                }

                throw Exception();
              },
            ),
          ),
        ),
      ),
    );
  }

  Duration getCurrentPregnancyProgress(
          DateTime firstDay, DateTime currentDay) =>
      currentDay.difference(firstDay);

  Color getCellColor(Trimester trimester) {
    switch (trimester) {
      case Trimester.ONE:
        {
          return const Color(0xFFFFA07A);
        }

      case Trimester.TWO:
        {
          return const Color(0xFFFFD700);
        }

      case Trimester.THREE:
        {
          return const Color(0xFF9B870C);
        }

      case Trimester.INVALID:
        {
          return Colors.transparent;
        }
    }
  }
}
