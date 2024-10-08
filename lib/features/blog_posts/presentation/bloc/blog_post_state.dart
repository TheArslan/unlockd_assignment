part of 'blog_post_bloc.dart';
// states of blog post page

@immutable
abstract class BlogPostState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial State
class BlogPostInitial extends BlogPostState {}

// Loading State
class BlogLoadingState extends BlogPostState {}

// BlogPostSuccess state
class BlogPostSuccess extends BlogPostState {
  final List<BlogPostEntity> posts;
  BlogPostSuccess({required this.posts});
  @override
  List<Object> get props => [posts];
}

// BlogPost failes state
class BlogPostFailed extends BlogPostState {
  final String message;

  BlogPostFailed(this.message);
  @override
  List<Object> get props => [message];
}

// State when Logout  is susccess
class LogOutSuccess extends BlogPostState {
  final bool logoutUser;
  LogOutSuccess({required this.logoutUser});
  @override
  List<Object> get props => [logoutUser];
}

// state  when logout is failed

class LogouFailed extends BlogPostState {
  final String message;

  LogouFailed(this.message);
  @override
  List<Object> get props => [message];
}
