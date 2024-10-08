import 'dart:convert';

import 'package:unlockd_assignment/core/constants/api_constants.dart';
import 'package:unlockd_assignment/core/error/exceptions.dart';

import 'package:http/http.dart' as http;
import 'package:unlockd_assignment/features/blog_posts/data/models/blog_post_model.dart';

// class to interact with server
abstract class BlogPostRemoteDataSource {
  Future<List<BlogPostModel>> getBlogPosts(String token);
}

class BlogPostRemoteDataSourceImpl extends BlogPostRemoteDataSource {
  final http.Client client;

  BlogPostRemoteDataSourceImpl({required this.client});

  // functio to fetch posts from server
  @override
  Future<List<BlogPostModel>> getBlogPosts(String token) async {
    final response = await client.get(
      Uri.parse(ApiURLConstants.blogPosts),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);

      return jsonList
          .map(
            (e) => BlogPostModel.fromJson(e),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
