import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:slibro/application/res/palette.dart';
import 'package:slibro/utils/database.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  final DatabaseClient _databaseClient = DatabaseClient();
  late final User _user;

  @override
  void initState() {
    _user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'My Profile',
            style: TextStyle(
              color: Palette.black,
              fontSize: 36.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const CircleAvatar(
                minRadius: 30,
                backgroundColor: Palette.greyMedium,
                child: Icon(
                  Icons.person,
                  color: Palette.black,
                  size: 36,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                        color: Palette.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.user.email,
                    style: const TextStyle(
                      color: Palette.greyDark,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () async {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit Profile'),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
