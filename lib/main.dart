import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/login_screen.dart';
import 'package:slibro/presentation/screens/splash_screen.dart';
import 'package:slibro/secrets.dart';

import 'application/res/strings.dart';

Client client = Client();

void main() {
  runApp(MyApp());

  client
      .setEndpoint(Secrets.hostname)
      .setProject(Secrets.projectID)
      .setSelfSigned(status: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Palette.black,
            fontSize: 32.0,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
          headline2: TextStyle(
            color: Palette.black,
            fontSize: 32.0,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
          bodyText1: TextStyle(
            color: Palette.black,
            fontSize: 16.0,
            // letterSpacing: 1,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: TextStyle(
            color: Palette.blackLight,
            fontSize: 14.0,
            letterSpacing: 1,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Palette.blackLight,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 14.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(
              color: Palette.white,
              fontSize: 20.0,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
