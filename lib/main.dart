import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/login_screen.dart';

import 'application/res/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
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
      ),
      home: LoginScreen(),
    );
  }
}
