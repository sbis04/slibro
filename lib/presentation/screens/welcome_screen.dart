import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:slibro/application/res/palette.dart';

class WelcomeScreen extends StatefulWidget {
  final User user;

  const WelcomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final TextEditingController _nameController;
  late final FocusNode _nameFocus;
  late final User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;

    _nameController = TextEditingController(text: _currentUser.displayName);
    _nameFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocus.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Palette.greyDark.withOpacity(0.8)),
                      ),
                      TextField(
                        controller: _nameController,
                        focusNode: _nameFocus,
                        textCapitalization: TextCapitalization.words,
                        style: Theme.of(context).textTheme.headline1,
                        cursorColor: Palette.greyLight,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 5),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Palette.greyLight,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Palette.greyMedium,
                            ),
                          ),
                          hintText: 'Enter your name',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Palette.greyLight),
                        ),
                        onChanged: (value) {
                          if (value == '') {
                            setState(() {});
                          } else if (value.length == 1) {
                            setState(() {});
                          }
                        },
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'You can edit your name above',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Palette.greyMedium),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: _nameController.text.isEmpty ? null : () {},
                    child: Text('Continue'),
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
