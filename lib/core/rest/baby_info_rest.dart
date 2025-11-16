import 'dart:convert';
import 'dart:typed_data' show Uint8List;
import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/models/baby_info.dart';
import 'package:dio/dio.dart';

import '../services/session_storage_service.dart';

class WeekInfoRest {
  static final WeekInfoRest _instance = WeekInfoRest._internal();

  WeekInfoRest._internal();

  static WeekInfoRest get instance => _instance;

  final _inMemoryCache = <String, dynamic>{};

  Future<List<WeekInfoResModel>?> fetchWeekInfo(int week) async {
    final raw =  await _fetchResponse(week, [
      "id",
      "week_start",
      "week_end",
      "info_text",
      "info_type",
    ]);
    final list = (raw is List)
        ? raw
        .map((item) => WeekInfoResModel.buildFormOdooJson(item))
        .whereType<WeekInfoResModel>()
        .toList()
        : <WeekInfoResModel>[];

    return list;
  }

  Future<Uint8List?> fetchWeekImageInfo(int week) async {
  if(_inMemoryCache.containsKey('$week')){
      return _inMemoryCache['$week'];
    }
    final raw =  await _fetchResponse(week, [
      "photo"
    ]);
    if(raw is List && raw.isNotEmpty){
      for (var item in raw) {
        if(item is Map<String, dynamic> && item['photo'] is String){
          final imageBytes = base64Decode(item['photo']);
          _inMemoryCache['$week'] = imageBytes;
          return imageBytes;
        }
      }
    }
    return null;
  }

  Future<dynamic> _fetchResponse(
    int week,
    List<String> fields,
  ) async {
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
          "kwargs": {"fields": fields},
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
      return response.data['result'];
    } else {
      throw Exception('Failed to load baby info');
    }
  }
}
