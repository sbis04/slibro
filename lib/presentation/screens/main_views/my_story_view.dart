import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/story_writing/chapter_view.dart';
import 'package:slibro/utils/database.dart';

class MyStoryView extends StatefulWidget {
  const MyStoryView({Key? key}) : super(key: key);

  @override
  State<MyStoryView> createState() => _MyStoryViewState();
}

class _MyStoryViewState extends State<MyStoryView> {
  final DatabaseClient _databaseClient = DatabaseClient();
  List<Document>? _stories;

  _getStories() async {
    List<Document> publishedStories = [];
    final stories = await _databaseClient.getPublishedStories();

    for (int i = 0; i < stories.documents.length; i++) {
      final storyData = stories.documents[i].data;

      if (storyData['published'] == false) {
        publishedStories.add(stories.documents[i]);
      }
    }

    setState(() {
      _stories = publishedStories.reversed.toList();
    });
  }

  @override
  void initState() {
    _getStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Stories',
            style: TextStyle(
              color: Palette.black,
              fontSize: 36.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          _stories != null
              ? _stories!.isEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('No stories are available'),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        color: Palette.black,
                        onRefresh: () => _getStories(),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: _stories!.length,
                          itemBuilder: (context, index) {
                            final List<Document> retrievedStories = _stories!;
                            log(retrievedStories.length.toString());

                            final storyData = retrievedStories[index].data;
                            final String title = storyData['title'];
                            final String author = storyData['author'];

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChapterViewScreen(
                                        story: retrievedStories[index]),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                subtitle: Text('Written by $author'),
                              ),
                            );
                          },
                        ),
                      ),
                    )
              : Expanded(
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Palette.greyDark,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
