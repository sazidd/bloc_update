import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostRepository {
  Future<List<PostModel>> fetchPost(int startIndex, int limit) async {
    final response = await http.get(
        "https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit");
    if (response.statusCode != 200) {
      throw Exception('Failed to Fetch Data');
    }
    final jsonData = jsonDecode(response.body) as List;
    return jsonData.map((post) => PostModel.fromMap(post)).toList();
  }
}
