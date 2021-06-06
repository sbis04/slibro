import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/infrastructure/authentication.dart';
import 'package:slibro/presentation/screens/welcome_screen.dart';
import 'package:slibro/presentation/widgets/splash_screen/google_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Palette.white,
      statusBarIconBrightness: Brightness.dark,
    ));

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
                    'assets/storel_logo_black.png',
                    height: 160,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Slibro',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            FutureBuilder<User?>(
                future: Authentication.initializeFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    User? currentUser = snapshot.data;

                    if (currentUser != null) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(
                              user: currentUser,
                            ),
                          ),
                        );
                      });

                      return Container();
                    } else {
                      return GoogleButton();
                    }
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Palette.greyDark,
                    ),
                  );
                }),
            SizedBox(height: 32.0)
          ],
        ),
      ),
    );
  }
}
