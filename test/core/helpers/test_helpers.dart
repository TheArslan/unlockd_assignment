import 'package:mockito/annotations.dart';
import 'package:unlockd_assignment/core/storages/secure_storage.dart';
import 'package:unlockd_assignment/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:unlockd_assignment/features/auth/domain/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:unlockd_assignment/features/auth/domain/usecases/login_user.dart';
import 'package:unlockd_assignment/features/auth/domain/usecases/logout_user.dart';
import 'package:unlockd_assignment/features/blog_posts/data/data_sources/blog_post_remote_data_source.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/repositories/blog_post_repository.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/usecases/get_blog_posts.dart';
import 'package:unlockd_assignment/features/blog_posts/presentation/bloc/blog_post_bloc.dart';

@GenerateMocks([
  AuthRepository,
  AuthRemoteDataSource,
  LoginUser,
  BlogPostRepository,
  BlogPostRemoteDataSource,
  GetBlogPosts,
  SecureStorage,
  LogOutUser,
  BlogPostBloc,
], customMocks: [
  MockSpec<http.Client>(
    as: #MockHttpClient,
  ),
])
void main() {}
