import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/usecases/get_blog_posts.dart';

import '../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late GetBlogPosts getBlogPosts;
  late MockBlogPostRepository mockBlogPostRepository;

  const testBlogPost = [
    BlogPostEntity(
        id: 1,
        title: "Unlocking the Secrets of Flutter Development",
        description: "An insightful post on Flutter best practices.",
        imageUrl: "https://example.com/images/flutter_blog.png")
  ];
  setUp(
    () {
      mockBlogPostRepository = MockBlogPostRepository();
      getBlogPosts = GetBlogPosts(mockBlogPostRepository);
    },
  );
  test(
    "fetch blog posts",
    () async {
      //arrange
      when(mockBlogPostRepository.getBlogPosts()).thenAnswer(
        (_) async => const Right(testBlogPost),
      );

      //act
      final result = await getBlogPosts.execute();

      //assert
      expect(result, const Right(testBlogPost));
    },
  );
}
