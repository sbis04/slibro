import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:slibro/application/res/palette.dart';

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
  late final quill.QuillController _quillController;

  @override
  void initState() {
    _quillController = quill.QuillController.basic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
            preferredSize: const Size(double.maxFinite, 100),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 22.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: TextField(
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
                    // onChanged: (value) => widget.onChange(value),
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
          onPressed: () {},
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
