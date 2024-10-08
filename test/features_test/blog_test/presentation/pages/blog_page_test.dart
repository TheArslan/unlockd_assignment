import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';
import 'package:unlockd_assignment/core/widget/network_image_view.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';
import 'package:unlockd_assignment/features/blog_posts/presentation/bloc/blog_post_bloc.dart';
import 'package:unlockd_assignment/features/blog_posts/presentation/pages/blog_post_page.dart';

import '../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late MockBlogPostBloc mockBlogPostBloc;

  setUp(() {
    mockBlogPostBloc = MockBlogPostBloc();
    final sl = GetIt.instance;
    sl.registerFactory<BlogPostBloc>(() => mockBlogPostBloc);
    HttpOverrides.global = null;
  });
  tearDown(() {
    // Unregister the bloc after the test
    GetIt.instance.reset();
  });

  // Test Case 1: Should show loading indicator when BlogLoadingState is emitted
  testWidgets('should show loading indicator when BlogLoadingState is emitted',
      (WidgetTester tester) async {
    // Arrange

    when(mockBlogPostBloc.state).thenReturn(BlogLoadingState());
    when(mockBlogPostBloc.stream)
        .thenAnswer((_) => Stream.value(BlogLoadingState()));

    when(mockBlogPostBloc.posts).thenReturn([]);
    // Act
    await tester.pumpWidget(
      BlocProvider<BlogPostBloc>(
        create: (_) => mockBlogPostBloc,
        child: const MaterialApp(
          home: BlogPostPage(),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // Test Case 2: Should show blog post list when BlogPostSuccess is emitted
  testWidgets('should show blog post list when BlogPostSuccess is emitted',
      (WidgetTester tester) async {
    // Arrange
    final blogPosts = [
      const BlogPostEntity(
        id: 1,
        title: "Unlocking the Secrets of Flutter Development",
        description: "An insightful post on Flutter best practices.",
        imageUrl: "https://example.com/images/flutter_blog.png",
      ),
    ];

    // Mock the state and stream
    when(mockBlogPostBloc.posts).thenReturn(blogPosts);
    when(mockBlogPostBloc.state).thenReturn(BlogPostSuccess(posts: blogPosts));

    when(mockBlogPostBloc.stream).thenAnswer(
      (_) => Stream.value(BlogPostSuccess(posts: blogPosts)),
    );

    // Act
    await tester.pumpWidget(
      BlocProvider<BlogPostBloc>.value(
        value: mockBlogPostBloc,
        child: const MaterialApp(
          home: BlogPostPage(),
        ),
      ),
    );

    // Allow time for animations or transitions
    await tester.pump();

    // Assert

    expect(
      find.byType(Text),
      findsWidgets,
    );
    expect(find.byType(NetworkImageView), findsOneWidget);
  });

  // Test Case 3: Should show error message when BlogPostFailed is emitted
  testWidgets('should show error message when BlogPostFailed is emitted',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'No blog post found';
    when(mockBlogPostBloc.posts).thenReturn([]);
    when(mockBlogPostBloc.state).thenReturn(BlogPostFailed(errorMessage));
    when(mockBlogPostBloc.stream).thenAnswer(
      (_) => Stream.value(BlogPostFailed(errorMessage)),
    );

    // Act
    await tester.pumpWidget(
      BlocProvider<BlogPostBloc>(
        create: (_) => mockBlogPostBloc,
        child: const MaterialApp(
          home: BlogPostPage(),
        ),
      ),
    );
    // Allow time for animations or transitions
    await tester.pumpAndSettle();

    // Assert
    expect(find.text(errorMessage), findsOneWidget);
  });

  // Test Case 4: Should show no blogs found message when no blogs are available
}
