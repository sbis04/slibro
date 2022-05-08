import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/main.dart';
import 'package:slibro/presentation/screens/greet_screen.dart';
import 'package:slibro/presentation/screens/register_screen.dart';
import 'package:slibro/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _loginFormKey,
          onChanged: () => setState(() {}),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w500,
                    color: Palette.black,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailTextController,
                  focusNode: _emailFocusNode,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Palette.black,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Palette.greyMedium,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.black,
                        width: 3,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.black.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    hintText: 'Enter email',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Palette.black.withOpacity(0.5),
                    ),
                  ),
                  validator: (value) => Validators.validateEmail(
                    email: value,
                  ),
                  // onChanged: (value) => widget.onChange(value),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  obscureText: true,
                  controller: _passwordTextController,
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Palette.black,
                  ),
                  cursorColor: Palette.greyMedium,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.black,
                        width: 3,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.black.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    hintText: 'Enter password',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Palette.black.withOpacity(0.5),
                    ),
                  ),
                  validator: (value) => Validators.validatePassword(
                    password: value,
                  ),
                  // onChanged: (value) => widget.onChange(value),
                ),
                const SizedBox(height: 32),
                Wrap(
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Palette.greyDark,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Palette.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      // TODO: Comment this out
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => GreetScreen(),
                        ),
                      );
                      // if (_loginFormKey.currentState!.validate()) {
                      //   Account account = Account(client);
                      //   Session userSession = await account
                      //       .createSession(
                      //     email: _emailTextController.text,
                      //     password: _passwordTextController.text,
                      //   )
                      //       .catchError((error) {
                      //     log(error.response);
                      //   });

                      //   log('User logged in successfully: ${userSession.userId}');
                      // }
                    },
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
