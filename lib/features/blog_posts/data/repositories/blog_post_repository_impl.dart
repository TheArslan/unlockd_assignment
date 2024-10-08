import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:unlockd_assignment/core/error/exceptions.dart';
import 'package:unlockd_assignment/core/error/failure.dart';
import 'package:unlockd_assignment/core/storages/secure_storage.dart';

import 'package:unlockd_assignment/features/blog_posts/data/data_sources/blog_post_remote_data_source.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';

import 'package:unlockd_assignment/features/blog_posts/domain/repositories/blog_post_repository.dart';

// Immplementation of BlogPostRepository class and implement functions
class BlogPostRepositoryImpl implements BlogPostRepository {
  final BlogPostRemoteDataSource blogPostRemoteDataSource;
  final SecureStorage secureStorage;
  const BlogPostRepositoryImpl(
      {required this.blogPostRemoteDataSource, required this.secureStorage});
  // function to fetch blog post
  @override
  Future<Either<Failure, List<BlogPostEntity>>> getBlogPosts() async {
    try {
      // fetch user token from secured storage
      final token = await secureStorage.getToken();
      // if no token found then return error
      if (token == null) {
        return const Left(ServerFailure("UnAuthenticated"));
      }
      final result = await blogPostRemoteDataSource.getBlogPosts(token);
      return Right(result
          .map(
            (e) => e.toEntity(),
          )
          .toList());
    } on ServerException {
      return const Left(ServerFailure("Server Error"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to internet"));
    }
  }
}
