import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/presentation/screens/story_writing/chapter_description.dart';
import 'package:slibro/presentation/screens/story_writing/writing_view.dart';
import 'package:slibro/utils/validators.dart';

class StoryNameScreen extends StatefulWidget {
  const StoryNameScreen({Key? key}) : super(key: key);

  @override
  State<StoryNameScreen> createState() => _StoryNameScreenState();
}

class _StoryNameScreenState extends State<StoryNameScreen> {
  final _nameFormKey = GlobalKey<FormState>();

  late final TextEditingController _nameTextController;
  late final FocusNode _nameFocusNode;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _nameFocusNode = FocusNode();
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
                        // TODO: Comment this out
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                const ChapterDescriptionScreen(),
                          ),
                        );
                      },
                      child: const Text('Continue to Chapters'),
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
