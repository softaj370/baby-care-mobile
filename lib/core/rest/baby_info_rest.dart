import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/models/baby_info.dart';
import 'package:dio/dio.dart';

import '../services/session_storage_service.dart';

class WeekInfoRest {
  static final WeekInfoRest _instance = WeekInfoRest._internal();

  WeekInfoRest._internal();

  static WeekInfoRest get instance => _instance;

  Future<List<WeekInfoResModel>?> fetchWeekInfo(int week) async {
    final dio = Dio(BaseOptions(baseUrl: AppConstance.apiBaseUrl));
    final response = await dio.post(
      AppConstance.callKw,
      data: {
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "model": "mother.baby.info",
          "method": "get_info_for_week",
          "args": [week],
          "kwargs": {},
        },
        "id": 1,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          "Cookie": "session_id=${SessionStorageService.instance.getSession()}",
        },
      ),
    );

    if (response.statusCode == 200) {
      final raw = response.data['result'];
      final list = (raw is List)
          ? raw
                .map((item) => WeekInfoResModel.buildFormOdooJson(item))
                .whereType<WeekInfoResModel>()
                .toList()
          : <WeekInfoResModel>[];
      return list;
    } else {
      throw Exception('Failed to load baby info');
    }
  }
}
