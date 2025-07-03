import 'package:baby_care/core/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStorageService {
  static final SessionStorageService _instance =
      SessionStorageService._internal();
  late SharedPreferences _sharedPreferences;

  SessionStorageService._internal();

  static SessionStorageService get instance => _instance;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getSession() => _sharedPreferences.getString(StorageKey.sessionId);

  Future<void> saveSession(String value) async =>
      await _sharedPreferences.setString(StorageKey.sessionId, value);

  Future<void> clearSession() async =>
      await _sharedPreferences.remove(StorageKey.sessionId);
}
