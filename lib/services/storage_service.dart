// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:uuid/uuid.dart';

// class StorageService {
//   static Future<String> uploadItemImage(String userId, File file) async {
//     final ext = file.path.split('.').last;
//     final ref = FirebaseStorage.instance
//         .ref('items/$userId/${const Uuid().v4()}.$ext');
//     await ref.putFile(file);
//     return ref.getDownloadURL();
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class StorageService {
  static Future<String> uploadItemImage(
      String userId,
      File file,
      ) async {

    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/deqf7mpfq/image/upload',
    );

    var request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = 'flutter_upload';

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final data = jsonDecode(
        await response.stream.bytesToString(),
      );

      return data['secure_url'];
    }

    throw Exception('Image upload failed');
  }
}