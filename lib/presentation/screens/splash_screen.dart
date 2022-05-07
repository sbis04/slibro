import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(
            //     Palette.greyDark,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Get Started'),
                ),
              ),
            ),
            // FutureBuilder<User?>(
            //   future: Authentication.initializeFirebase(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       User? currentUser = snapshot.data;

            //       if (currentUser != null) {
            //         WidgetsBinding.instance!.addPostFrameCallback((_) {
            //           Navigator.of(context).pushReplacement(
            //             MaterialPageRoute(
            //               builder: (context) => WelcomeScreen(
            //                 user: currentUser,
            //               ),
            //             ),
            //           );
            //         });

            //         return Container();
            //       } else {
            //         return GoogleButton();
            //       }
            //     }
            //     return CircularProgressIndicator(
            //       valueColor: AlwaysStoppedAnimation<Color>(
            //         Palette.greyDark,
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 42.0)
          ],
        ),
      ),
    );
  }
}

class LoginSheet extends StatefulWidget {
  const LoginSheet({Key? key}) : super(key: key);

  @override
  State<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.black,
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Text('Login')),
                Tab(icon: Text('Create Account')),
              ],
            ),
            SizedBox(
              height: 280 + MediaQuery.of(context).viewInsets.bottom,
              child: TabBarView(
                children: [
                  Form(
                    // key: _loginFormKey,
                    onChanged: () => setState(() {}),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          TextFormField(
                            // controller: _emailTextController,
                            // focusNode: _emailFocusNode,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Palette.white,
                            ),
                            cursorColor: Theme.of(context).colorScheme.primary,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 3,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                              hintText: 'Enter email',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Palette.white.withOpacity(0.6),
                              ),
                            ),
                            // validator: (value) => Validators.validateEmail(
                            //   email: value,
                            // ),
                            // onChanged: (value) => widget.onChange(value),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            obscureText: true,
                            // controller: _passwordTextController,
                            // focusNode: _passwordFocusNode,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Palette.white,
                            ),
                            cursorColor: Theme.of(context).colorScheme.primary,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 3,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                              hintText: 'Enter password',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Palette.white.withOpacity(0.6),
                              ),
                            ),
                            // validator: (value) => Validators.validatePassword(
                            //   password: value,
                            // ),
                            // onChanged: (value) => widget.onChange(value),
                          ),
                          const SizedBox(height: 36),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () async {},
                              child: const Text('Get Started'),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  Icon(Icons.directions_transit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
