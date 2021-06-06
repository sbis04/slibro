import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slibro/application/res/palette.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Palette.greyDark,
              ),
            ),
            SizedBox(height: 32.0)
          ],
        ),
      ),
    );
  }
}
