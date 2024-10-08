import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unlockd_assignment/core/error/failure.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';
import 'package:unlockd_assignment/features/blog_posts/presentation/bloc/blog_post_bloc.dart';

import '../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late MockGetBlogPosts mockGetBlogPosts;
  late BlogPostBloc blogPostBloc;
  late MockLogOutUser mockLogOutUser;

  const testBlogPost = [
    BlogPostEntity(
        id: 1,
        title: "Unlocking the Secrets of Flutter Development",
        description: "An insightful post on Flutter best practices.",
        imageUrl: "https://example.com/images/flutter_blog.png")
  ];

  setUp(
    () {
      mockGetBlogPosts = MockGetBlogPosts();
      mockLogOutUser = MockLogOutUser();
      blogPostBloc = BlogPostBloc(mockGetBlogPosts, mockLogOutUser);
    },
  );

  test(
    "Initial State",
    () {
      expect(blogPostBloc.state, BlogPostInitial());
    },
  );
  blocTest<BlogPostBloc, BlogPostState>(
      "should emit [Loading State,BlogPostSuccess]",
      build: () {
        when(mockGetBlogPosts.execute()).thenAnswer(
          (_) async => const Right(testBlogPost),
        );

        return blogPostBloc;
      },
      act: (bloc) => bloc.add(const OnblogPostFetch()),
      expect: () => [BlogLoadingState(), BlogPostSuccess(posts: testBlogPost)]);

  blocTest<BlogPostBloc, BlogPostState>(
      "should emit [Loading State,BlogPostFailed]",
      build: () {
        when(mockGetBlogPosts.execute()).thenAnswer(
          (_) async => const Left(ServerFailure("Server failure")),
        );
        return blogPostBloc;
      },
      act: (bloc) => bloc.add(const OnblogPostFetch()),
      expect: () => [BlogLoadingState(), BlogPostFailed("Server failure")]);

  blocTest<BlogPostBloc, BlogPostState>(
      "should emit [Loading State,BlogPostSuccess]",
      build: () {
        when(mockLogOutUser.execute()).thenAnswer(
          (_) async => const Right(true),
        );
        return blogPostBloc;
      },
      act: (bloc) => bloc.add(const OnblogOutPressed()),
      expect: () => [BlogLoadingState(), LogOutSuccess(logoutUser: true)]);

  blocTest<BlogPostBloc, BlogPostState>(
      "should emit [Loading State,BlogPostFailed]",
      build: () {
        when(mockLogOutUser.execute()).thenAnswer(
          (_) async => const Left(ServerFailure("Server failure")),
        );
        return blogPostBloc;
      },
      act: (bloc) => bloc.add(const OnblogOutPressed()),
      expect: () => [BlogLoadingState(), LogouFailed("Server failure")]);
}
