import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slibro/application/res/appwrite_const.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/main.dart';
import 'package:slibro/presentation/screens/login_screen.dart';

import 'greet_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isGettingUser = true;
  String? _userID;

  getLoggedInUserId() async {
    setState(() {
      _isGettingUser = true;
    });

    Account account = Account(client);

    final prefs = await SharedPreferences.getInstance();
    final String? userEmail = prefs.getString(authEmailSharedPrefKey);
    final String? userPassword = prefs.getString(authPasswordSharedPrefKey);

    if (userEmail != null && userPassword != null) {
      final Session session = await account.createSession(
        email: userEmail,
        password: userPassword,
      );

      User loggedInUser = await account.get();

      // TODO: Navigate to the dashboard
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => GreetScreen(
            user: loggedInUser,
          ),
        ),
      );
    }

    setState(() {
      _isGettingUser = false;
    });
  }

  @override
  void initState() {
    getLoggedInUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(),
                  Image.asset(
                    'assets/slibro_logo_black.png',
                    height: 160,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Slibro',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: _isGettingUser
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Palette.greyDark,
                            ),
                          ),
                        )
                      : const Text('Get Started'),
                ),
              ),
            ),
            const SizedBox(height: 42.0)
          ],
        ),
      ),
    );
  }
}
