import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static Future<String?> uploadImage(File imageFile) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/deqf7mpfq/image/upload',
    );

    var request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = 'flutter_upload';

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final data =
          jsonDecode(await response.stream.bytesToString());

      return data['secure_url'];
    }

    return null;
  }
}