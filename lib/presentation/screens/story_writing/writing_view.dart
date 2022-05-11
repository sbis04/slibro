import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:path_provider/path_provider.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/utils/database.dart';
import 'package:slibro/utils/storage.dart';
import 'dart:io' as io;

import 'package:slibro/utils/validators.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({
    Key? key,
    required this.story,
  }) : super(key: key);

  final Document story;

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final _storyFormKey = GlobalKey<FormState>();
  late final quill.QuillController _quillController;
  late final TextEditingController _storyNameController;
  late final FocusNode _storyNameFocusNode;

  final StorageClient _storageClient = StorageClient();
  final DatabaseClient _databaseClient = DatabaseClient();

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

    Document? updatedStory = await _databaseClient.addStoryFile(
      documentID: widget.story.$id,
      fileID: storyFile.$id,
    );

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _quillController = quill.QuillController.basic();
    _storyNameController = TextEditingController();
    _storyNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: const Text('CHAPTER 2'),
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
                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme:
                          TextSelectionTheme.of(context).copyWith(
                        cursorColor: Colors.black,
                      ),
                    ),
                    child: quill.QuillEditor.basic(
                      controller: _quillController,
                      readOnly: false,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
          child: const Icon(
            Icons.check,
            size: 30,
          ),
          backgroundColor: Palette.black,
        ),
      ),
    );
  }
}
