import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/film_mini_info.dart';
import 'screens/onboarding_page.dart';
import 'theme.dart';
import '/screens/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TileDataAdapter());
  await Hive.openBox<TileData>('tileData');
  var prefs = await SharedPreferences.getInstance();
  var boolKey = 'isFirstTime';
  var isFirstTime = prefs.getBool(boolKey) ?? true;
  runApp(MyApp(prefs: prefs, isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final SharedPreferences prefs;
  static const boolKey = 'isFirstTime';
  const MyApp({
    Key? key,
    required this.isFirstTime,
    required this.prefs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CineGenics",
      theme: AppTheme.dark(),
      home: isFirstTime
          ? IntroScreen(prefs: prefs, boolKey: boolKey)
          : const HomeScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  final SharedPreferences prefs;
  final String boolKey;
  const IntroScreen({Key? key, required this.prefs, required this.boolKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    prefs.setBool(boolKey, false);
    return const OnBoardingPage();
  }
}
