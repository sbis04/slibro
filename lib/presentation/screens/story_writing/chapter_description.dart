import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/story_writing/chapter_view.dart';
import 'package:slibro/presentation/screens/story_writing/writing_view.dart';
import 'package:slibro/utils/validators.dart';

class ChapterDescriptionScreen extends StatefulWidget {
  const ChapterDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<ChapterDescriptionScreen> createState() =>
      _ChapterDescriptionScreenState();
}

class _ChapterDescriptionScreenState extends State<ChapterDescriptionScreen> {
  final _nameFormKey = GlobalKey<FormState>();

  late final TextEditingController _nameTextController;
  late final TextEditingController _descriptionTextController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
    _nameFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Palette.black,
          ),
          elevation: 0,
          backgroundColor: Palette.white,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _nameFormKey,
              onChanged: () => setState(() {}),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 80),
                    TextFormField(
                      controller: _nameTextController,
                      focusNode: _nameFocusNode,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Palette.black,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
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
                        hintText: 'Enter chapter name',
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
                    TextFormField(
                      controller: _descriptionTextController,
                      focusNode: _descriptionFocusNode,
                      maxLines: 4,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Palette.black,
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Palette.greyMedium,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Palette.black,
                            width: 3,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Palette.black.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        hintText: 'Enter chapter description',
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
                      'The chapter description will give an overview of the chapter to the readers, creating a better experience.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Palette.black,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () async {
                          // TODO: Comment this out
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const ChapterViewScreen(),
                            ),
                          );
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
