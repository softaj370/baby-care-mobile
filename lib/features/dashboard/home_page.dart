import 'package:baby_care/core/services/local_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/daily_info_card.dart';
import 'package:baby_care/screens/main_info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int weeks = 0;
  late int days = 0;
  DateTime? selectedDate = LocalStorageService.instance.getSelectedDate();
  late List<Map<String, dynamic>> horDateList = getDateListWithPrefix();

  @override
  void initState() {
    super.initState();
    if (selectedDate != null) {
      weeks = (DateTime.now().difference(selectedDate!).inDays / 7).floor();
      days = DateTime.now().difference(selectedDate!).inDays;
    }
  }

  List<Map<String, dynamic>> getDateListWithPrefix() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    final totalDays = DateTime(year, month + 1, 0).day;

    return List.generate(totalDays, (index) {
      final date = DateTime(year, month, index + 1);
      return {'date': date.day, 'prefix': DateFormat('EEE').format(date)[0]};
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 48),
        child: Column(
          spacing: 16,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: horDateList.length,
                separatorBuilder: (context, index) => SizedBox(width: 12),
                itemBuilder: (itemBuilder, index) {
                  return calendarItem(
                    horDateList[index],
                    index,
                    DateTime.now().day - 1 == index,
                    DateTime.now().day - 5 == index,
                  );
                },
              ),
            ),
            SizedBox(
              width: 300,
              child: InkWell(
                borderRadius: BorderRadius.circular(200),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => MainInfoPage()),
                  );
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bubble-circle.png"),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Image.asset("assets/images/baby.png"),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Week ",
                                  style: TextStyle(
                                    height: 0,
                                    color: AppColors.textColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  weeks.toString(),
                                  style: TextStyle(
                                    height: 0,
                                    color: AppColors.textColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Day ",
                                  style: TextStyle(
                                    height: 0,
                                    color: AppColors.textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  days.toString(),
                                  style: TextStyle(
                                    height: 0,
                                    color: AppColors.textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {},
              child: Image.asset(
                "assets/images/add-button-shadow.png",
                height: 68,
              ),
            ),
            PhysicalModel(
              elevation: 20,
              shadowColor: AppColors.secondaryColor,
              color: Colors.transparent,
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: DailyInfoCard(
                  icon: CupertinoIcons.cloud,
                  title: "Daily Cards - Info",
                  detail: "Upload Image to start",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget calendarItem(
    Map<String, dynamic> item,
    int index,
    bool isSelected,
    bool isActive,
  ) {
    return Container(
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: isSelected
            ? LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : LinearGradient(colors: [Colors.white, Colors.white]),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 6,
        children: [
          Text(
            "${item["prefix"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.grayTextColor,
            ),
          ),
          Text(
            "${item["date"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.textColor,
            ),
          ),
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.primaryColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
