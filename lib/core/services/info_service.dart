
import 'package:baby_care/core/models/baby_info.dart';
import 'package:baby_care/core/rest/baby_info_rest.dart';

class InfoService {
  static final InfoService _instance = InfoService._internal();
  InfoService._internal();
  static InfoService get instance => _instance;

    Future<WeekInfoModel> getBabyInfoStream(int week) async {
        final babyInfoList = await WeekInfoRest.instance.fetchWeekInfo(4);
        final weekInfoModel = WeekInfoModel(
        );
        if (babyInfoList != null) {
          for (var info in babyInfoList) {
            if (info.type == BabyInfoType.baby) {
              if (weekInfoModel.babyInfo.isNotEmpty) {
                weekInfoModel.babyInfo += "\n";
              }
              weekInfoModel.babyInfo +=  info.infoText;
            } else if (info.type == BabyInfoType.mother) {
              if (weekInfoModel.motherInfo.isNotEmpty) {
                weekInfoModel.motherInfo += "\n";
              }
              weekInfoModel.motherInfo += info.infoText;
            }
          }
        }
        return weekInfoModel;
    }

}