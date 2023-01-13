import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BabyCalendarScreen extends StatefulWidget {
  final Color? screenBackground;

  const BabyCalendarScreen({Key? key, required this.screenBackground})
      : super(key: key);

  @override
  State<BabyCalendarScreen> createState() => _BabyCalendarScreenState();
}

class _BabyCalendarScreenState extends State<BabyCalendarScreen> {
  var firstDay = DateTime.utc(2022, 11, 2);
  var lastDay = DateTime.utc(2023, 8, 30);
  var currentDay = DateTime.now();
  var focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var currentPregnancyDuration =
        getCurrentPregnancyProgress(firstDay, currentDay);
    String currentProgress =
        "${currentPregnancyDuration.inDays ~/ 7} weeks, and ${currentPregnancyDuration.inDays % 7} days";

    return Container(
      color: widget.screenBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Current pregnancy status: $currentProgress",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Trimester ${calculateTrimester(currentPregnancyDuration.inDays)}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            TableCalendar(
              firstDay: firstDay,
              lastDay: lastDay,
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(currentDay, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  currentDay = selected;
                  focusedDay = focused;
                });
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
                        color: getCellColor(firstDay, day),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: Text(day.day.toString())),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Duration getCurrentPregnancyProgress(
          DateTime firstDay, DateTime currentDay) =>
      currentDay.difference(firstDay);

  int calculateTrimester(int currentDay) {
    if (currentDay <= 98) {
      return 1;
    } else if (currentDay > 98 && currentDay <= 196) {
      return 2;
    } else if (currentDay > 196 && currentDay <= 280) {
      return 3;
    } else {
      return 4;
    }
  }

  Color getCellColor(DateTime firstDay, DateTime cellDay) {
    int currentProgress = getCurrentPregnancyProgress(firstDay, cellDay).inDays;
    int trimester = calculateTrimester(currentProgress);

    switch (trimester) {
      case 1:
        {
          return const Color(0xFFFFA07A);
        }

      case 2:
        {
          return const Color(0xFFFFD700);
        }

      case 3:
        {
          return const Color(0xFF9B870C);
        }

      default:
        {
          return Colors.transparent;
        }
    }
  }
}
