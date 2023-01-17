import 'dart:convert';

import 'package:baby_age/data/user_preferences_data_source.dart';
import 'package:baby_age/domain/model/date_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesRepository extends UserPreferencesDataSource {
  @override
  Future<DateInfo> getStoredStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    String? startDateJson = prefs.getString("start_date");
    return DateInfo.fromJson(startDateJson);
  }

  @override
  Future<bool> saveStartDate(DateInfo startDate) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("start_date", jsonEncode(startDate));
  }
}
