import 'package:baby_care/core/services/local_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainInfoPage extends StatefulWidget {
  const MainInfoPage({super.key});

  @override
  State<MainInfoPage> createState() => _MainInfoPageState();
}

class _MainInfoPageState extends State<MainInfoPage> {
  late int weeks, remainingWeeks = 0;
  late int days, remainingDays = 0;
  DateTime? selectedDate = DateTime.now();

  final List<bool> _isOpen = List.generate(2, (_) => true);

  final String _details =
      "In week 8 the embryo looks more and more like a human, instead of an alien. The head is about half of the entire body length. The little face continues to";

  final int _dayForDelivery = 280;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (selectedDate != null) {
      selectedDate = LocalStorageService.instance.getSelectedDate();
      int totalDays = DateTime.now().difference(selectedDate!).inDays;
      weeks = totalDays ~/ 7;
      days = totalDays % weeks;


      int totalRemainingDays = _dayForDelivery - totalDays;
      remainingWeeks = totalRemainingDays ~/ 7;
      remainingDays = totalRemainingDays % weeks;

    }
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
              child: Image.asset(
                'assets/images/small-baby.png',
                fit: BoxFit.cover,
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
                  ExpansionPanelList(
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
                            _details,
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
                            _details,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
