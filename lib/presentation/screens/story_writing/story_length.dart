import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/story_writing/story_name.dart';

class StoryLengthScreen extends StatelessWidget {
  const StoryLengthScreen({
    Key? key,
    required this.user,
    this.isInitial = false,
  }) : super(key: key);

  final User user;
  final bool isInitial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select the length of your story',
                style: TextStyle(
                  color: Palette.greyDark,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StoryNameScreen(
                          isShort: true,
                          user: user,
                          isInitial: isInitial,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Short',
                        style: TextStyle(
                          fontSize: 24,
                          color: Palette.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'This format doesn\'t support chapter creation and has a word limit of 5000 words.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Palette.greyLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StoryNameScreen(
                          user: user,
                          isShort: false,
                          isInitial: isInitial,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Regular',
                        style: TextStyle(
                          fontSize: 24,
                          color: Palette.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'You can use chapters and has an unlimited word limit.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Palette.greyLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
