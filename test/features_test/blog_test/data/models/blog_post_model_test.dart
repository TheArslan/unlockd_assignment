import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:unlockd_assignment/features/blog_posts/data/models/blog_post_model.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';

import '../../../../core/helpers/helper_functions.dart';

void main() {
  const testBlogPosts = [
    BlogPostModel(
        id: 1,
        title: "Unlocking the Secrets of Flutter Development",
        description: "An insightful post on Flutter best practices.",
        imageUrl: "https://example.com/images/flutter_blog.png")
  ];
  test(
    "should be subclass of blogpost entity ",
    () {
      //assert
      expect(testBlogPosts, isA<List<BlogPostEntity>>());
    },
  );

  test(
    "should return a valid model from json",
    () {
      //arrange
      final List<dynamic> jsonList = json
          .decode(readJson("core/dummy_data/dummy_blog_post_response.json"));
      //act

      final result = jsonList
          .map(
            (e) => BlogPostModel.fromJson(e),
          )
          .toList();

      //assert
      expect(result, equals(testBlogPosts));
    },
  );

  test(
    "should return a valid json from model;",
    () {
      //arrange
      final List<dynamic> jsonMap = json
          .decode(readJson("core/dummy_data/dummy_blog_post_response.json"));
      //act

      final result = testBlogPosts
          .map(
            (e) => e.toJson(),
          )
          .toList();
      //assert
      expect(result, equals(jsonMap));
    },
  );
}
