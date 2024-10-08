part of 'blog_post_bloc.dart';

// evets of BlogPostPage
abstract class BlogPostEvent extends Equatable {
  const BlogPostEvent();
  @override
  List<Object?> get props => [];
}

// event to fetch blog posts
class OnblogPostFetch extends BlogPostEvent {
  const OnblogPostFetch();
  @override
  List<Object?> get props => [];
}

// evennt  to logout user
class OnblogOutPressed extends BlogPostEvent {
  const OnblogOutPressed();
  @override
  List<Object?> get props => [];
}
