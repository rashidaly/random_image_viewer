import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageRepository {
  static const apiUrl =
      'https://november7-730026606190.europe-west1.run.app/image';

  Future<String> fetchRandomImage() async {
    final response = await http
        .get(Uri.parse(apiUrl))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch image (Status: ${response.statusCode})");
    }

    final jsonData = json.decode(response.body);
    return jsonData['url'];
  }
}
