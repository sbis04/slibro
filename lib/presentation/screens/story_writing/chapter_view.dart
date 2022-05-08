import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/story_writing/chapter_description.dart';
import 'package:slibro/presentation/screens/story_writing/writing_view.dart';
import 'package:slibro/utils/validators.dart';

class ChapterViewScreen extends StatefulWidget {
  const ChapterViewScreen({Key? key}) : super(key: key);

  @override
  State<ChapterViewScreen> createState() => _ChapterViewScreenState();
}

class _ChapterViewScreenState extends State<ChapterViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.black,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Story title',
                  style: TextStyle(
                    color: Palette.white,
                    fontSize: 38,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHAPTER 1',
                          style: TextStyle(
                            color: Palette.greyDark,
                            fontSize: 12,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Chapter name here',
                          style: TextStyle(
                            color: Palette.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Palette.greyMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  'Here there would be the chapter description, which might be a bit longer. You can have around 2-4 sentences.',
                  style: TextStyle(
                    color: Palette.greyMedium,
                    fontSize: 14,
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
