import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:slibro/application/res/appwrite_const.dart';
import 'package:slibro/main.dart';
import 'package:tuple/tuple.dart';

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

  Future<Document> addChapterFile({
    required String documentID,
    required String fileID,
  }) async {
    final Document updatedChapter = await database.updateDocument(
      collectionId: chaptersCollectionId,
      documentId: documentID,
      data: {'file': fileID},
    );

    log('Updated document successfully, ID: ${updatedChapter.$id}');

    return updatedChapter;
  }

  Future<Tuple2<Document, Document>> createChapter({
    required String documentID,
    required String name,
    required String description,
    required int number,
  }) async {
    final Map<String, dynamic> data = {
      'name': name,
      'number': number,
      'description': description,
      'file': null,
    };

    final Document newChapter = await database
        .createDocument(
      collectionId: chaptersCollectionId,
      documentId: 'unique()',
      data: data,
    )
        .catchError((e) {
      log(
        'Error creating doc: ${e.toString()}',
      );
    });

    log('Chapter created successfully: ${newChapter.$id}');

    final updatedStory = await addChapterToStory(
      documentID: documentID,
      chapterID: newChapter.$id,
    );

    return Tuple2(updatedStory, newChapter);
  }

  Future<Document> addChapterToStory({
    required String documentID,
    required String chapterID,
  }) async {
    final Document story = await database.getDocument(
      collectionId: storiesCollectionId,
      documentId: documentID,
    );

    final List<String> chapters = List<String>.from(story.data['chapters']);

    if (chapters.contains(chapterID)) return story;

    chapters.add(chapterID);
    final Document updatedStory = await database.updateDocument(
      collectionId: storiesCollectionId,
      documentId: documentID,
      data: {'chapters': chapters},
    );

    log('Updated document successfully, ID: ${updatedStory.$id}');

    return updatedStory;
  }

  Future<DocumentList> getPublishedStories() async {
    final DocumentList pubStories = await database.listDocuments(
      collectionId: storiesCollectionId,
    );

    return pubStories;
  }

  Future<List<Document>> getChapters({required List<String> chapterIds}) async {
    List<Document> chapters = [];

    for (int i = 0; i < chapterIds.length; i++) {
      final chapterData = await database
          .getDocument(
        collectionId: chaptersCollectionId,
        documentId: chapterIds[i],
      )
          .catchError((e) {
        log('Error retrieving chapter: ${e.toString()}');
      });

      chapters.add(chapterData);
    }

    return chapters;
  }

  Future<Document> publishStory({required String storyId}) async {
    final Document updatedStory = await database.updateDocument(
      collectionId: storiesCollectionId,
      documentId: storyId,
      data: {'published': true},
    );

    log('Published story successfully, ID: ${updatedStory.$id}');

    return updatedStory;
  }

  Future<Document> unpublishStory({required String storyId}) async {
    final Document updatedStory = await database.updateDocument(
      collectionId: storiesCollectionId,
      documentId: storyId,
      data: {'published': false},
    );

    log('Unpublished story successfully, ID: ${updatedStory.$id}');

    return updatedStory;
  }
}
