import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/srory_reading/reading_view.dart';
import 'package:slibro/presentation/screens/story_writing/chapter_description.dart';
import 'package:slibro/presentation/screens/story_writing/writing_view.dart';
import 'package:slibro/utils/database.dart';
import 'package:slibro/utils/storage.dart';

class ChapterViewScreen extends StatefulWidget {
  const ChapterViewScreen({
    Key? key,
    required this.story,
    required this.user,
  }) : super(key: key);

  final Document story;
  final User user;

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
          actions: [
            widget.user.$id == _storyData['uid']
                ? _storyData['published']
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextButton(
                          onPressed: () async {
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
                                          'Unpublishing...',
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
                            await _databaseClient.unpublishStory(
                                storyId: widget.story.$id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Unpublish',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextButton(
                          onPressed: () async {
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
                                          'Publishing...',
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
                            await _databaseClient.publishStory(
                                storyId: widget.story.$id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Publish',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                : const SizedBox()
          ],
        ),
        floatingActionButton: widget.user.$id == _storyData['uid']
            ? FloatingActionButton(
                backgroundColor: Colors.red.shade200,
                onPressed: () {},
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent.shade700,
                ),
              )
            : const SizedBox(),
        body: SafeArea(
          child: SingleChildScrollView(
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
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _chapters!.length,
                          separatorBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Divider(
                              color: Palette.greyDark,
                            ),
                          ),
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
                                      widget.user.$id == _storyData['uid']
                                          ? IconButton(
                                              onPressed: () async {
                                                // log('tapped edit');
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) => Dialog(
                                                    backgroundColor:
                                                        Palette.greyDark,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
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
                                                                color: Palette
                                                                    .white,
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
                                                    await _storageClient
                                                        .getJSONFile(
                                                  fileID: chapter['file'],
                                                );

                                                Navigator.of(context).pop();

                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WritingScreen(
                                                      story: widget.story,
                                                      isShort: widget.story
                                                          .data['is_short'],
                                                      chapter:
                                                          retrievedChapters[
                                                              index],
                                                      jsonString: jsonString,
                                                      user: widget.user,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Palette.greyMedium,
                                              ),
                                            )
                                          : const SizedBox(),
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
                        )
                      : Container(),
                  const SizedBox(height: 32),
                  widget.user.$id == _storyData['uid']
                      ? SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Palette.greyLight,
                            ),
                            onPressed: () async {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChapterDescriptionScreen(
                                    story: widget.story,
                                    isShort: widget.story.data['is_short'],
                                    chapterNumber:
                                        widget.story.data['chapters'].length +
                                            1,
                                    user: widget.user,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Add Chapter',
                              style: TextStyle(
                                color: Palette.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
