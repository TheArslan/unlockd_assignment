import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unlockd_assignment/core/constants/api_constants.dart';
import 'package:unlockd_assignment/core/error/exceptions.dart';

import 'package:http/http.dart' as http;

import 'package:unlockd_assignment/features/blog_posts/data/data_sources/blog_post_remote_data_source.dart';
import 'package:unlockd_assignment/features/blog_posts/data/models/blog_post_model.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late BlogPostRemoteDataSourceImpl blogPostRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    blogPostRemoteDataSourceImpl =
        BlogPostRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    "get blog posts",
    () {
      test(
        "should return Blog list when the response is 200",
        () async {
          // arrange
          when(mockHttpClient.get(
            Uri.parse(
              ApiURLConstants.blogPosts,
            ),
            headers: anyNamed("headers"),

            // {
            //   'Accept': 'application/json',
            //   'Authorization': 'Bearer dahgsdhjasdbgyucjhsad'
            // },
          )).thenAnswer((_) async => http.Response(
              readJson("core/dummy_data/dummy_blog_post_response.json"), 200));

          // act

          final result =
              await blogPostRemoteDataSourceImpl.getBlogPosts("token");

          //assert

          expect(result, isA<List<BlogPostModel>>());
        },
      );
      test(
        "should throw Exception when the response is 404 or other",
        () async {
          // arrange
          when(mockHttpClient.get(
            Uri.parse(
              ApiURLConstants.blogPosts,
            ),
            headers: anyNamed("headers"),
          )).thenAnswer((_) async => http.Response("Server Error", 404));

          // act

          final result = blogPostRemoteDataSourceImpl.getBlogPosts("token");

          //assert

          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
