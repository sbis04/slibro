import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:slibro/application/res/appwrite_const.dart';
import 'package:slibro/main.dart';

class StorageClient {
  Storage storage = Storage(client);

  Future<File> storeJSONFile({
    required String filePath,
    required String fileName,
  }) async {
    File file = await storage
        .createFile(
      bucketId: filesBucketId,
      fileId: 'unique()',
      file: InputFile(
        path: filePath,
        filename: fileName,
      ),
    )
        .catchError((e) {
      log(
        'Error storing file: ${e.toString()}',
      );
    });

    log('File successfully stored, ID: ${file.$id}');

    return file;
  }
}
