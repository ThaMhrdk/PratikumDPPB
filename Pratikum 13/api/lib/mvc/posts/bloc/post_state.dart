part of 'post_bloc.dart';

enum PostStatus { initial, loading, success, failure }

class PostState extends Equatable {
  const PostState({
    required this.status,
    required this.posts,
    required this.message,
  });

  const PostState.initial()
    : status = PostStatus.initial,
      posts = const [],
      message = "";

  final PostStatus status;
  final List<PostModel> posts;
  final String message;

  PostState copyWith({
    PostStatus? status,
    List<PostModel>? posts,
    String? message,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, posts, message];
}
