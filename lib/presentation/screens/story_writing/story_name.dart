import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/story_writing/chapter_description.dart';
import 'package:slibro/presentation/screens/story_writing/writing_view.dart';
import 'package:slibro/utils/database.dart';
import 'package:slibro/utils/validators.dart';
import 'package:tuple/tuple.dart';

class StoryNameScreen extends StatefulWidget {
  const StoryNameScreen({
    Key? key,
    required this.isShort,
    required this.user,
    this.isInitial = false,
  }) : super(key: key);

  final bool isShort;
  final User user;
  final bool isInitial;

  @override
  State<StoryNameScreen> createState() => _StoryNameScreenState();
}

class _StoryNameScreenState extends State<StoryNameScreen> {
  final _nameFormKey = GlobalKey<FormState>();

  late final TextEditingController _nameTextController;
  late final FocusNode _nameFocusNode;
  late final DatabaseClient _databaseClient;
  bool isStoring = false;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _nameFocusNode = FocusNode();
    _databaseClient = DatabaseClient();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _nameFormKey,
            onChanged: () => setState(() {}),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameTextController,
                    focusNode: _nameFocusNode,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Palette.black,
                    ),
                    textInputAction: TextInputAction.done,
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
                      hintText: 'Enter story name',
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
                  const Text(
                    'You will be able to change the story name before publishing.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Palette.black,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        _nameFocusNode.unfocus();
                        if (_nameFormKey.currentState!.validate()) {
                          setState(() {
                            isStoring = true;
                          });
                          Document newStory = await _databaseClient.addStory(
                            user: widget.user,
                            storyName: _nameTextController.text,
                            isShort: widget.isShort,
                          );

                          if (widget.isShort) {
                            Tuple2<Document, Document> storyAndChapter =
                                await _databaseClient.createChapter(
                              documentID: newStory.$id,
                              number: 1,
                              name: 'default',
                              description: 'story',
                            );

                            final retrievedStory = storyAndChapter.item1;
                            final retrievedChapter = storyAndChapter.item2;

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => WritingScreen(
                                  story: retrievedStory,
                                  chapter: retrievedChapter,
                                  isShort: widget.isShort,
                                  user: widget.user,
                                  isInitial: widget.isInitial,
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ChapterDescriptionScreen(
                                  story: newStory,
                                  chapterNumber: 1,
                                  isShort: widget.isShort,
                                  user: widget.user,
                                  isInitial: widget.isInitial,
                                ),
                              ),
                            );
                          }
                          setState(() {
                            isStoring = false;
                          });
                        }
                      },
                      child: isStoring
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Palette.greyDark,
                                ),
                              ),
                            )
                          : const Text('Continue to Chapters'),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
