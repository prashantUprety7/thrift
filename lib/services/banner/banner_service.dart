import 'dart:convert';

import'package:http/http.dart'as http;

class BannerApi {
  static Future<List<String>> fetchBannerImages() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    final List<dynamic> data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      final List<String> imageUrlList =
      data.map((item) => item['url'] as String).toList();
      return imageUrlList;
    } else {
      throw Exception('Failed to load banner images');
    }
  }
}
