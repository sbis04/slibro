import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:slibro/application/res/appwrite_const.dart';
import 'package:slibro/main.dart';

class DatabaseClient {
  Database database = Database(client);

  Future<Document> addStory({
    required User user,
    required String storyName,
    required bool isShort,
  }) async {
    final Map<String, dynamic> data = {
      'uid': user.$id,
      'title': storyName,
      'author': user.name,
      'contents': null,
      'is_short': isShort,
    };

    final Document newStory = await database
        .createDocument(
      collectionId: storiesCollectionId,
      documentId: 'unique()',
      data: data,
    )
        .catchError((e) {
      log(
        'Error creating doc: ${e.toString()}',
      );
    });

    log('Doc created successfully: ${newStory.$id}');

    return newStory;
  }

  Future<Map<String, dynamic>> getStory({
    required User user,
  }) async {
    Database database = Database(client);

    final storyData = await database
        .getDocument(
      collectionId: storiesCollectionId,
      documentId: user.$id,
    )
        .catchError((e) {
      log(
        'Error retrieving doc: ${e.toString()}',
      );
    });

    return storyData.data;
  }

  Future<Document?> addStoryFile({
    required String documentID,
    required String fileID,
  }) async {
    final Document story = await database.getDocument(
      collectionId: storiesCollectionId,
      documentId: documentID,
    );

    final List<String> contents = List<String>.from(story.data['contents']);

    if (contents.contains(fileID)) return null;

    contents.add(fileID);
    final Document updatedStory = await database.updateDocument(
      collectionId: storiesCollectionId,
      documentId: documentID,
      data: {'contents': contents},
    );

    log('Updated document successfully, ID: ${updatedStory.$id}');

    return updatedStory;
  }
}
