import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:unlockd_assignment/core/storages/secure_storage.dart';
import 'package:unlockd_assignment/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:unlockd_assignment/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:unlockd_assignment/features/auth/domain/repositories/auth_repository.dart';
import 'package:unlockd_assignment/features/auth/domain/usecases/login_user.dart';
import 'package:unlockd_assignment/features/auth/domain/usecases/logout_user.dart';
import 'package:unlockd_assignment/features/auth/presentation/bloc/login_bloc.dart';
import 'package:unlockd_assignment/features/blog_posts/data/data_sources/blog_post_remote_data_source.dart';
import 'package:unlockd_assignment/features/blog_posts/data/repositories/blog_post_repository_impl.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/repositories/blog_post_repository.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/usecases/get_blog_posts.dart';
import 'package:unlockd_assignment/features/blog_posts/presentation/bloc/blog_post_bloc.dart';

final GetIt locator = GetIt.instance;
// function to initailize dependencies
void setUpLocator() {
  locator.registerFactory(
    () => LoginBloc(locator()),
  );
  locator.registerLazySingleton(
    () => LoginUser(locator()),
  );
  locator.registerLazySingleton(
    () => LogOutUser(locator()),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
        userRemoteDataSource: locator(), secureStorage: locator()),
  );

  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton(
    () => http.Client(),
  );

  locator.registerFactory<BlogPostBloc>(
    () => BlogPostBloc(locator(), locator()),
  );
  locator.registerLazySingleton(
    () => GetBlogPosts(locator()),
  );
  locator.registerLazySingleton<BlogPostRepository>(
    () => BlogPostRepositoryImpl(
        blogPostRemoteDataSource: locator(), secureStorage: locator()),
  );
  locator.registerLazySingleton<BlogPostRemoteDataSource>(
    () => BlogPostRemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton<SecureStorage>(
    () => SecureStorageImp(),
  );
}
