import 'package:adkar_flutter/pages/display_page.dart';
import 'package:adkar_flutter/services/dictionary.dart';
import 'package:adkar_flutter/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/about_page.dart';
import 'pages/home_page.dart';

const MyColor = const Color(0xFFFF0D0538);
void main() {
   // Initialiser l'application Get
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LanguageTranslation(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('arb', 'MA'),
      title: 'Adkar',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
    routes: {
      "/": (context) => SplashScreen(),
      "/home": (context) => HomePage(),
      "/details": (context) => DisplayPage(),
      "/about": (context) => AboutPage(),
    }
    );
  }
}


