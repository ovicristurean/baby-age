import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BabyCalendarScreen extends StatefulWidget {
  const BabyCalendarScreen({Key? key}) : super(key: key);

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
      color: Colors.blueGrey,
      child: Center(
        child: Column(
          children: [
            Text("Current pregnancy status: $currentProgress"),
            Text(
                "Trimester ${calculateTrimester(currentPregnancyDuration.inDays)}"),
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
    } else {
      return 3;
    }
  }
}
