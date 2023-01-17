
import 'package:baby_age/domain/model/date_info.dart';

abstract class UserPreferencesDataSource {
  Future<DateInfo> getStoredStartDate();

  Future<bool> saveStartDate(DateInfo startDate);
}
