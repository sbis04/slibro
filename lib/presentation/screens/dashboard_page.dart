import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slibro/application/res/appwrite_const.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/main.dart';
import 'package:slibro/presentation/screens/login_screen.dart';
import 'package:slibro/presentation/screens/main_views/my_profile.dart';
import 'package:slibro/presentation/screens/story_writing/story_length.dart';

import 'main_views/home_view.dart';
import 'main_views/my_story_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
    required this.user,
    this.selectedIndex = 0,
  }) : super(key: key);

  final User user;
  final int selectedIndex;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark,
    //   ),
    // );
    _selectedIndex = widget.selectedIndex;
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
        child: _selectedIndex == 0
            ? HomeView(
                user: widget.user,
              )
            : _selectedIndex == 1
                ? MyStoryView(
                    user: widget.user,
                  )
                : MyProfileView(
                    user: widget.user,
                  ),
      ),
      floatingActionButtonLocation: _selectedIndex != 2
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _selectedIndex != 2
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StoryLengthScreen(user: widget.user),
                  ),
                );
                SystemChrome.setSystemUIOverlayStyle(
                  const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
              backgroundColor: Palette.black,
            )
          : FloatingActionButton.extended(
              onPressed: () async {
                Account account = Account(client);

                final prefs = await SharedPreferences.getInstance();
                await prefs.setString(
                  authEmailSharedPrefKey,
                  '',
                );
                await prefs.setString(
                  authPasswordSharedPrefKey,
                  '',
                );
                // log((await account.getSessions()).toString());
                // final SessionList sessionList = await account.getSessions();
                // await account.deleteSession(
                //   sessionId: sessionList.sessions.first.$id,
                // );
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              label: const Text('Log out'),
              backgroundColor: Palette.black,
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Palette.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Palette.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.book_rounded,
                  text: 'My Stories',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
