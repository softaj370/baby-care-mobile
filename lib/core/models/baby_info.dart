enum BabyInfoType { mother, baby }

class WeekInfoResModel {
  int weekStart;
  int weekEnd;
  String infoText;
  BabyInfoType type;

  WeekInfoResModel({
    required this.weekStart,
    required this.weekEnd,
    required this.infoText,
    required this.type,
  });

  static buildFormOdooJson(Map<String, dynamic> json) {
    return WeekInfoResModel(
      weekStart: json['week_start'],
      weekEnd: json['week_end'],
      infoText: json['info_text'],
      type: json['info_type'] == 'mother' ? BabyInfoType.mother : BabyInfoType.baby,
    );
  }
}

class WeekInfoModel {
  String photo;
  String motherInfo;
  String babyInfo;

  WeekInfoModel({
    this.photo = '',
    this.motherInfo = '', this.babyInfo = ''});
}
