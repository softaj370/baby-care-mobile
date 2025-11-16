import 'dart:typed_data' show Uint8List;

import 'package:baby_care/core/models/baby_info.dart';
import 'package:baby_care/core/services/info_service.dart';
import 'package:baby_care/core/services/local_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/rest/baby_info_rest.dart';

class MainInfoPage extends StatefulWidget {
  const MainInfoPage({super.key});

  @override
  State<MainInfoPage> createState() => _MainInfoPageState();
}

class _MainInfoPageState extends State<MainInfoPage> {
  late int weeks, remainingWeeks = 0;
  late int days, remainingDays = 0;
  DateTime? selectedDate = DateTime.now();
  late Future<Uint8List?> _babyImageFuture;
  final List<bool> _isOpen = List.generate(2, (_) => true);

  final int _dayForDelivery = 280;

  late Future<WeekInfoModel> _weekInfoFuture;

  @override
  void initState() {
    super.initState();
    if (selectedDate != null) {
      selectedDate = LocalStorageService.instance.getSelectedDate();
      int totalDays = DateTime.now().difference(selectedDate!).inDays;
      if (totalDays < 7) {
        weeks = 0;
        days = totalDays;
        remainingWeeks = (_dayForDelivery - totalDays) ~/ 7;
        remainingDays = (_dayForDelivery - totalDays) % 7;
      } else {
        weeks = totalDays ~/ 7;
        days = totalDays % weeks;

        int totalRemainingDays = _dayForDelivery - totalDays;
        remainingWeeks = totalRemainingDays ~/ 7;
        remainingDays = totalRemainingDays % weeks;
      }
      _babyImageFuture = WeekInfoRest.instance.fetchWeekImageInfo(weeks > 0 ? weeks : 1);
    }

    // Fetch week info based on current week
    _weekInfoFuture = InfoService.instance.getBabyInfoStream(weeks > 0 ? weeks : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.black45),
          ),
          color: Colors.red,
          icon: Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            child: AspectRatio(
              aspectRatio: 0.8,
              child:  FutureBuilder<Uint8List?>(
                future: _babyImageFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }

                  // Display base64 image if available, otherwise show default
                  if (snapshot.hasData && snapshot.data != null) {
                    try {
                      final Uint8List imageBytes = snapshot.data! ;
                      return Image.memory(
                        imageBytes,
                        height: 150,
                        fit: BoxFit.cover,
                      );
                    } catch (e) {
                      // If casting fails, show default image
                      return Image.asset("assets/images/small-baby.png", fit: BoxFit.cover);
                    }
                  }

                  // Default image
                  return Image.asset("assets/images/small-baby.png",fit: BoxFit.cover);
                },
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBlue,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${weeks.toString()} weeks and ${days.toString()} days',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '1 Trimester',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: 0.6,
                          backgroundColor: Colors.white24,
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          minHeight: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date of labor ${DateFormat.yMd().format(selectedDate!)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '$remainingWeeks weeks and $remainingDays days left',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<WeekInfoModel>(
                    future: _weekInfoFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: EdgeInsets.all(32),
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.cardBlue,
                            ),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Container(
                          padding: EdgeInsets.all(32),
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'Error loading information',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      }

                      final weekInfo = snapshot.data;
                      final babyInfo = weekInfo?.babyInfo ?? 'No information available';
                      final motherInfo = weekInfo?.motherInfo ?? 'No information available';

                      return ExpansionPanelList(
                        materialGapSize: 0,
                        expansionCallback: (index, isOpen) {
                          setState(() {
                            _isOpen[index] = !_isOpen[index];
                          });
                        },
                        elevation: 0,
                        animationDuration: Duration(milliseconds: 200),
                        expandedHeaderPadding: EdgeInsets.all(0),
                        expandIconColor: Colors.white,
                        children: [
                          ExpansionPanel(
                            canTapOnHeader: true,
                            isExpanded: _isOpen[0],
                            backgroundColor: AppColors.darkRed,
                            headerBuilder: (context, isOpen) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  "Baby",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                            body: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                babyInfo,
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          ExpansionPanel(
                            canTapOnHeader: true,
                            isExpanded: _isOpen[1],
                            backgroundColor: AppColors.lightOrange,
                            headerBuilder: (context, isOpen) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  "Mother",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                            body: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                motherInfo,
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
