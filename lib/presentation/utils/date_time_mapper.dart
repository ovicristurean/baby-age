import 'package:intl/intl.dart';

import '../baby_calendar_screen/viewdata/pregnancy_progress.dart';

class DateTimeMapper {
  static String formatDate(DateTime time) =>
      DateFormat('MMMM dd yyyy').format(time);

  static Trimester getTrimesterForProgress(int progress) {
    if (progress <= 98) {
      return Trimester.ONE;
    } else if (progress <= 196) {
      return Trimester.TWO;
    } else if (progress <= 280) {
      return Trimester.THREE;
    } else {
      return Trimester.INVALID;
    }
  }
}
