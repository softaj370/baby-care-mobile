import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  late SharedPreferences _sharedPreferences;

  LocalStorageService._internal();

  static LocalStorageService get instance => _instance;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  DateTime? getSelectedDate() {
    String? temp = _sharedPreferences.getString(StorageKey.selectedDate);
    return temp != null ? DateTime.tryParse(temp) : null;
  }

  Future<void> saveSelectedDate(DateTime date) async => await _sharedPreferences
      .setString(StorageKey.selectedDate, date.toString());

  Future<void> clearSelectedDate() async =>
      await _sharedPreferences.remove(StorageKey.selectedDate);

  Future<void> saveUserFullName(String name) async =>
      await _sharedPreferences.setString(AppConstants.userFullName, name);

  Future<void> clearUserFullName() async =>
      await _sharedPreferences.remove(AppConstants.userFullName);

  String getUserFullName() {
    return _sharedPreferences.getString(AppConstants.userFullName) ?? "";
  }
}
