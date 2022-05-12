import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:path_provider/path_provider.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/dashboard_page.dart';
import 'package:slibro/presentation/screens/story_writing/chapter_view.dart';
import 'package:slibro/utils/database.dart';
import 'package:slibro/utils/storage.dart';
import 'dart:io' as io;

import 'package:slibro/utils/validators.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({
    Key? key,
    required this.story,
    required this.isShort,
    required this.chapter,
    this.user,
    this.isInitial = false,
    this.jsonString,
  }) : super(key: key);

  final Document story;
  final Document chapter;
  final bool isShort;
  final bool isInitial;
  final User? user;
  final String? jsonString;

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final _storyFormKey = GlobalKey<FormState>();
  late final quill.QuillController _quillController;
  late final TextEditingController _storyNameController;
  late final FocusNode _storyNameFocusNode;
  late final FocusNode _storyContentFocusNode;
  late final ScrollController _scrollController;

  final StorageClient _storageClient = StorageClient();
  final DatabaseClient _databaseClient = DatabaseClient();

  int _totalCharacters = 0;

  _saveDocument({required String fileName}) async {
    final json = jsonEncode(
      _quillController.document.toDelta().toJson(),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Palette.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 30,
          ),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Saving...',
                  style: TextStyle(
                    color: Palette.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Palette.greyDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = io.File('$path/$fileName.json');
    await file.writeAsString(json);

    log('Saved file path: ${file.path}');

    File storyFile = await _storageClient.storeJSONFile(
      filePath: file.path,
      fileName: '$fileName.json',
    );

    Document updatedChapter = await _databaseClient.addChapterFile(
      documentID: widget.chapter.$id,
      fileID: storyFile.$id,
    );

    Navigator.of(context).pop();

    if (widget.isInitial) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => DashboardPage(
            user: widget.user!,
            selectedIndex: 1,
          ),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ChapterViewScreen(
            story: widget.story,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.jsonString != null) {
      var jsonFile = jsonDecode(widget.jsonString!);
      _quillController = quill.QuillController(
        document: quill.Document.fromJson(jsonFile),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _quillController = quill.QuillController.basic();
    }

    _storyNameController = TextEditingController(
      text: widget.chapter.data['name'],
    );
    _storyNameFocusNode = FocusNode();
    _storyContentFocusNode = FocusNode();
    _scrollController = ScrollController();

    _quillController.addListener(() {
      log('LENGTH: ${_quillController.document.length}');
      setState(() {
        _totalCharacters = _quillController.document.length;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.chapter.data['name']);
    return GestureDetector(
      onTap: () {
        _storyNameFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('CHAPTER ${widget.chapter.data['number']}'),
          ),
          backgroundColor: Palette.black,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size(double.maxFinite, 120),
            child: Form(
              key: _storyFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 22.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: TextFormField(
                      controller: _storyNameController,
                      focusNode: _storyNameFocusNode,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Palette.greyLight,
                      ),
                      cursorColor: Palette.greyMedium,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Palette.greyLight.withOpacity(0.6),
                            width: 3,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Palette.greyLight.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        hintText: 'Enter the chapter name',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Palette.white.withOpacity(0.4),
                        ),
                      ),
                      validator: (value) => Validators.validateName(
                        name: value,
                      ),
                    ),
                  ),
                  quill.QuillToolbar.basic(
                    toolbarIconSize: 26,
                    iconTheme: const quill.QuillIconTheme(
                      iconSelectedFillColor: Colors.white,
                      iconSelectedColor: Palette.black,
                      iconUnselectedFillColor: Colors.transparent,
                      iconUnselectedColor: Palette.greyMedium,
                      disabledIconColor: Palette.greyDark,
                      disabledIconFillColor: Colors.transparent,
                    ),
                    dialogTheme: quill.QuillDialogTheme(
                      dialogBackgroundColor: Palette.white,
                    ),
                    controller: _quillController,
                    showUndo: false,
                    showRedo: false,
                    showVideoButton: false,
                    multiRowsDisplay: false,
                    showBackgroundColorButton: true,
                    showClearFormat: false,
                    showCameraButton: false,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 100.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme:
                          TextSelectionTheme.of(context).copyWith(
                        cursorColor: Colors.black,
                      ),
                    ),
                    child: quill.QuillEditor(
                      autoFocus: false,
                      scrollable: true,
                      focusNode: _storyContentFocusNode,
                      expands: false,
                      padding: EdgeInsets.zero,
                      scrollController: _scrollController,
                      controller: _quillController,
                      readOnly: false,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Palette.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Total characters: $_totalCharacters',
                            style: const TextStyle(
                              color: Palette.greyLight,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              CircleAvatar(
                radius: 30,
                backgroundColor: Palette.black,
                child: IconButton(
                  onPressed: () {
                    _storyNameFocusNode.unfocus();
                    if (_storyFormKey.currentState!.validate()) {
                      _saveDocument(
                        fileName: _storyNameController.text
                            .toLowerCase()
                            .replaceAll(' ', '_'),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                    color: Palette.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        // FloatingActionButton(
        //   onPressed: () {
        //     _storyNameFocusNode.unfocus();
        //     if (_storyFormKey.currentState!.validate()) {
        //       _saveDocument(
        //         fileName: _storyNameController.text
        //             .toLowerCase()
        //             .replaceAll(' ', '_'),
        //       );
        //     }
        //   },
        //   child: const Icon(
        //     Icons.check,
        //     size: 30,
        //   ),
        //   backgroundColor: Palette.black,
        // ),
      ),
    );
  }
}
