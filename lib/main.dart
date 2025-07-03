import 'package:baby_care/core/services/local_storage_service.dart';
import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:baby_care/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionStorageService.instance.init();
  await LocalStorageService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const SplashScreen()
    );
  }
}