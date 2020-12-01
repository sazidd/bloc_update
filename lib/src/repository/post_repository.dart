import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostRepository {
  final _baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<PostModel>> fetchPost(int startIndex, int limit) async {
    final response =
        await http.get("$_baseUrl?_start=$startIndex&_limit=$limit");
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch the posts');
    }
    final jsonData = jsonDecode(response.body) as List;
    return jsonData.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<PostModel>> fetchSpecificPost(String userId) async {
    final response = await http.get("$_baseUrl?userId=$userId");
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch the specific post');
    }
    final jsonData = jsonDecode(response.body) as List;
    return jsonData.map((post) => PostModel.fromMap(post)).toList();
  }
}
