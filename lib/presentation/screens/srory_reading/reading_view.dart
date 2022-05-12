import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/utils/database.dart';
import 'package:slibro/utils/storage.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({
    Key? key,
    required this.story,
    required this.isShort,
    required this.chapter,
    required this.jsonString,
  }) : super(key: key);

  final Document story;
  final Document chapter;
  final bool isShort;
  final String jsonString;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late final quill.QuillController _quillController;
  late final ScrollController _scrollController;
  late final FocusNode _storyContentFocusNode;

  int _totalCharacters = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _storyContentFocusNode = FocusNode();

    var jsonFile = jsonDecode(widget.jsonString);
    _quillController = quill.QuillController(
      document: quill.Document.fromJson(jsonFile),
      selection: const TextSelection.collapsed(offset: 0),
    );

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
            child: Text('CHAPTER ${widget.chapter.data['number']}'),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.maxFinite, 50),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.chapter.data['name'],
                  style: const TextStyle(
                    color: Palette.greyLight,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
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
                      readOnly: true,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(left: 32.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Expanded(
        //         child: Container(
        //           width: double.maxFinite,
        //           height: 60,
        //           decoration: BoxDecoration(
        //             color: Palette.black,
        //             borderRadius: BorderRadius.circular(16),
        //           ),
        //           child: Center(
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(
        //                 horizontal: 16.0,
        //                 vertical: 8.0,
        //               ),
        //               child: Row(
        //                 children: [
        //                   Text(
        //                     'Total characters: $_totalCharacters',
        //                     style: const TextStyle(
        //                       color: Palette.greyLight,
        //                     ),
        //                   ),
        //                   const Spacer(),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       const SizedBox(width: 24),
        //       CircleAvatar(
        //         radius: 30,
        //         backgroundColor: Palette.black,
        //         child: IconButton(
        //           onPressed: () {},
        //           icon: const Icon(
        //             Icons.check,
        //             size: 30,
        //             color: Palette.white,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
