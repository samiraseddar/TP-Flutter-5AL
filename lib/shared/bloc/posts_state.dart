part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  error,
  empty,
  creating,
  updating,
}

class PostsState {
  final PostsStatus status;
  final List<Post> posts;
  final AppException? exception;
  final bool isProcessing;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.exception,
    this.isProcessing = false,
  });

  bool get isEmpty => posts.isEmpty && status == PostsStatus.success;
  bool get isLoading => status == PostsStatus.loading;
  bool get isError => status == PostsStatus.error;
  bool get isSuccess => status == PostsStatus.success;

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    AppException? exception,
    bool? isProcessing,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}