import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/srory_reading/reading_view.dart';
import 'package:slibro/presentation/screens/story_writing/writing_view.dart';
import 'package:slibro/utils/database.dart';
import 'package:slibro/utils/storage.dart';

class ChapterViewScreen extends StatefulWidget {
  const ChapterViewScreen({
    Key? key,
    required this.story,
  }) : super(key: key);

  final Document story;

  @override
  State<ChapterViewScreen> createState() => _ChapterViewScreenState();
}

class _ChapterViewScreenState extends State<ChapterViewScreen> {
  late final Map<String, dynamic> _storyData;
  final DatabaseClient _databaseClient = DatabaseClient();
  final StorageClient _storageClient = StorageClient();

  List<Document>? _chapters;

  getChapters() async {
    final chapters = await _databaseClient.getChapters(
      chapterIds: List<String>.from(_storyData['chapters']),
    );

    setState(() {
      _chapters = chapters;
    });
  }

  @override
  void initState() {
    _storyData = widget.story.data;
    getChapters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.story.data.toString());
    // log(widget.story.data.toString());
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
                  _storyData['title'],
                  style: const TextStyle(
                    color: Palette.white,
                    fontSize: 38,
                  ),
                ),
                const SizedBox(height: 16),
                _chapters != null
                    ? ListView.separated(
                        itemCount: _chapters!.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final retrievedChapters = _chapters!;
                          final chapter = retrievedChapters[index].data;

                          return InkWell(
                            onTap: () async {
                              // log('tapped');
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Dialog(
                                  backgroundColor: Palette.greyDark,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 30,
                                    ),
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Loading...',
                                            style: TextStyle(
                                              color: Palette.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Palette.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              final jsonString =
                                  await _storageClient.getJSONFile(
                                fileID: chapter['file'],
                              );

                              Navigator.of(context).pop();

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ReadingScreen(
                                    story: widget.story,
                                    isShort: widget.story.data['is_short'],
                                    chapter: retrievedChapters[index],
                                    jsonString: jsonString,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CHAPTER ${index + 1}',
                                          style: const TextStyle(
                                            color: Palette.greyDark,
                                            fontSize: 12,
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          chapter['name'],
                                          style: const TextStyle(
                                            color: Palette.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        // log('tapped edit');
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => Dialog(
                                            backgroundColor: Palette.greyDark,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 24.0,
                                                vertical: 30,
                                              ),
                                              child: SizedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text(
                                                      'Loading...',
                                                      style: TextStyle(
                                                        color: Palette.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          Palette.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        final jsonString =
                                            await _storageClient.getJSONFile(
                                          fileID: chapter['file'],
                                        );

                                        Navigator.of(context).pop();

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => WritingScreen(
                                              story: widget.story,
                                              isShort:
                                                  widget.story.data['is_short'],
                                              chapter: retrievedChapters[index],
                                              jsonString: jsonString,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Palette.greyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  // 'Here there would be the chapter description, which might be a bit longer. You can have around 2-4 sentences.',
                                  chapter['description'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    color: Palette.greyMedium,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
