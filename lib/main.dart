import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:komunoto/view/home_screen/home_screen.dart';
import 'package:komunoto/view/onboard/onboard_screen.dart';
import 'package:komunoto/view/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'function/firebase_options.dart';
import 'package:after_layout/after_layout.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Komunako App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  // Future checkLoginStatus() async {
  //   final user = FirebaseAuth.instance.currentUser;
    
  //   if (user != null) {
  //     Timer(
  //       const Duration(seconds: 3),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => const HomeScreen())),
  //     );
  //   } else {
  //     checkFirstSeen();
  //   }
  // }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      print(_seen);
      Timer(
          const Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen())));
    } else {
      await prefs.setBool('seen', true);
      Timer(
          const Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const OnboardingScreen())));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
