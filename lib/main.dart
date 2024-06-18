import 'package:adkar_flutter/pages/display_page.dart';
import 'package:adkar_flutter/services/dictionary.dart';
import 'package:adkar_flutter/splashscreen/sing_page.dart';
import 'package:adkar_flutter/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'pages/about_page.dart';
import 'pages/home_page.dart';

const MyColor = const Color(0xFFFF0D0538);

Future<void> main() async {
   
   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 print('Firebase initialized successfully.');

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
      "/sing": (context) => SignScreen(),
      "/home": (context) => HomePage(),
      "/details": (context) => DisplayPage(),
      "/about": (context) => AboutPage(),
    }
    );
  }
}


