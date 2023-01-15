import 'package:intl/intl.dart';

class DateTimeMapper {

  static String formatDate(DateTime time) => DateFormat('MMMM dd yyyy').format(time);
}
