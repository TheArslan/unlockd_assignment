import 'dart:io';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unlockd_assignment/core/error/failure.dart';

import 'package:unlockd_assignment/features/blog_posts/data/models/blog_post_model.dart';
import 'package:unlockd_assignment/features/blog_posts/data/repositories/blog_post_repository_impl.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';

import '../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late MockBlogPostRemoteDataSource mockBlogPostRemoteDataSource;
  late MockSecureStorage mockSecureStorage;
  late BlogPostRepositoryImpl blogPostRepositoryImpl;

  const testBlogPosts = [
    BlogPostModel(
        id: 1,
        title: "Unlocking the Secrets of Flutter Development",
        description: "An insightful post on Flutter best practices.",
        imageUrl: "https://example.com/images/flutter_blog.png")
  ];
  const dummyTokken = "This_is_A_test_Token";
  const testBlogEntity = [
    BlogPostEntity(
        id: 1,
        title: "Unlocking the Secrets of Flutter Development",
        description: "An insightful post on Flutter best practices.",
        imageUrl: "https://example.com/images/flutter_blog.png")
  ];

  setUp(
    () {
      mockBlogPostRemoteDataSource = MockBlogPostRemoteDataSource();
      mockSecureStorage = MockSecureStorage();
      blogPostRepositoryImpl = BlogPostRepositoryImpl(
          blogPostRemoteDataSource: mockBlogPostRemoteDataSource,
          secureStorage: mockSecureStorage);
    },
  );
  group(
    "should get blog posts",
    () {
      test(
        "should return blog posts when remote data source is success",
        () async {
          // arrange
          when(mockSecureStorage.getToken())
              .thenAnswer((_) async => dummyTokken);
          when(mockBlogPostRemoteDataSource.getBlogPosts(dummyTokken))
              .thenAnswer((_) async => testBlogPosts);

          //act

          final result = await blogPostRepositoryImpl.getBlogPosts();

          //assert
          expect(result, isA<Right<Failure, List<BlogPostEntity>>>());
          expect(result.fold((l) => null, (r) => r), equals(testBlogEntity));
        },
      );
      test(
        "should return Connection Failure",
        () async {
          // arrange
          when(mockSecureStorage.getToken())
              .thenAnswer((_) async => dummyTokken);
          when(mockBlogPostRemoteDataSource.getBlogPosts("token")).thenThrow(
              const SocketException("Failed to connect to internet"));

          //act

          final result = await blogPostRepositoryImpl.getBlogPosts();

          //assert

          expect(
              result,
              equals(const Left(
                  ConnectionFailure("Failed to connect to internet"))));
        },
      );
    },
  );
}
