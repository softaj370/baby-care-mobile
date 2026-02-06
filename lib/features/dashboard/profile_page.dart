import 'dart:typed_data';

import 'package:baby_care/core/services/info_service.dart';
import 'package:baby_care/core/services/local_storage_service.dart';
import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_button.dart';
import 'package:baby_care/core/widgets/daily_info_card.dart';
import 'package:baby_care/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int weeks = 0;

  DateTime? selectedDate = LocalStorageService.instance.getSelectedDate();
  String userName = LocalStorageService.instance.getUserFullName();
  late Future<Uint8List?> _babyImageFuture;

  @override
  void initState() {
    super.initState();
    if (selectedDate != null) {
      final totalDays = DateTime.now().difference(selectedDate!).inDays;
      weeks = totalDays ~/ 7;
    }
    // Fetch baby image for current week
    _babyImageFuture = InfoService.instance.getBabyImageInfoStream(
      weeks > 0 ? weeks : 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 68,
              child: Row(
                spacing: 8,
                children: [
                  FutureBuilder<Uint8List?>(
                    future: _babyImageFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: 68,
                          width: 68,
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
                          final Uint8List imageBytes = snapshot.data!;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(400),
                            ),
                            child: SizedBox(
                              height: 68,
                              width: 68,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipOval(
                                  child: Image.memory(
                                    imageBytes,
                                    height: 68,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } catch (e) {
                          // If casting fails, show default image
                          return Image.asset(
                            "assets/images/baby.png",
                            height: 68,
                          );
                        }
                      }

                      // Default image
                      return Image.asset("assets/images/baby.png", height: 68);
                    },
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome,",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
            SizedBox(height: 16,),
            CustomButton(text: "Log Out", onPressed: () {
              SessionStorageService.instance.clearSession();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );}),
          ],
        ),
      ),
    );
  }
}
