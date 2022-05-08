import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/main.dart';
import 'package:slibro/presentation/screens/login_screen.dart';
import 'package:slibro/presentation/screens/splash_screen.dart';
import 'package:slibro/utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  late final TextEditingController _userNameTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  late final TextEditingController _confirmPasswordTextController;

  late final FocusNode _userNameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _userNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();

    _userNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        _userNameFocusNode.unfocus();
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
        _confirmPasswordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _registerFormKey,
          onChanged: () => setState(() {}),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Palette.black,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _userNameTextController,
                  focusNode: _userNameFocusNode,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Palette.black,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
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
                    hintText: 'Enter name',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Palette.black.withOpacity(0.5),
                    ),
                  ),
                  validator: (value) => Validators.validateName(
                    name: value,
                  ),
                  // onChanged: (value) => widget.onChange(value),
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
                  style: const TextStyle(
                    fontSize: 16,
                    color: Palette.black,
                  ),
                  textInputAction: TextInputAction.next,

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
                TextFormField(
                  obscureText: true,
                  controller: _confirmPasswordTextController,
                  focusNode: _confirmPasswordFocusNode,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Palette.black,
                  ),
                  textInputAction: TextInputAction.done,
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
                    hintText: 'Confirm password',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Palette.black.withOpacity(0.5),
                    ),
                  ),
                  validator: (value) => Validators.validateConfirmPassword(
                    password: _passwordTextController.text,
                    confirmPassword: value,
                  ),
                  // onChanged: (value) => widget.onChange(value),
                ),
                const SizedBox(height: 32),
                Wrap(
                  children: [
                    const Text(
                      'Already have an account? ',
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
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
                      if (_registerFormKey.currentState!.validate()) {
                        Account account = Account(client);
                        User newUser = await account
                            .create(
                          userId: 'unique()',
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                          name: _userNameTextController.text,
                        )
                            .catchError((error) {
                          log(error.response.toString());
                        });

                        log('User account created successfully: ${newUser.$id}');
                      }
                    },
                    child: const Text('Sign Up'),
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
