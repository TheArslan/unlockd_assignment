import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlockd_assignment/features/auth/domain/usecases/logout_user.dart';

import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/usecases/get_blog_posts.dart';

part 'blog_post_state.dart';
part 'blog_post_event.dart';

// bloc of BlogPostPage to handle all states
class BlogPostBloc extends Bloc<BlogPostEvent, BlogPostState> {
  final GetBlogPosts _blogPosts;
  final LogOutUser _logOutUser;
  List<BlogPostEntity>? posts;
  BlogPostBloc(this._blogPosts, this._logOutUser) : super(BlogPostInitial()) {
    // handle OnblogPostFetch event
    on<OnblogPostFetch>(
      (event, emit) async {
        // emit loading state
        emit(BlogLoadingState());
        // fetch data
        final result = await _blogPosts.execute();
        // check response either failure or success
        result.fold(
          // if response is failes emit BlogPostFailed with error  message
          (failure) {
            emit(BlogPostFailed(failure.message));
          },
          // if response is sucees emit BlogPostSuccess with List
          (result) {
            emit(BlogPostSuccess(posts: result));
          },
        );
      },
    );
    // handle OnblogOutPressed event
    on<OnblogOutPressed>(
      (event, emit) async {
        // emit loading state
        emit(BlogLoadingState());
        // logout user
        final result = await _logOutUser.execute();
        // check response either failure or success
        result.fold(
          (failure) {
            // if response is failes emit LogouFailed with error  message
            emit(LogouFailed(failure.message));
          },
          // if response is sucees emit LogOutSuccess with true value
          (result) {
            emit(LogOutSuccess(logoutUser: result));
          },
        );
      },
    );
  }
}
