part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class PostFetched extends PostEvent {
  const PostFetched();
}

class PostRefreshed extends PostEvent {
  const PostRefreshed();
}

class PostCreated extends PostEvent {
  const PostCreated({
    required this.title,
    required this.author,
    required this.article,
    this.imageFile,
  });

  final String title;
  final String author;
  final String article;
  final dynamic imageFile;

  @override
  List<Object?> get props => [title, author, article, imageFile];
}

class PostUpdated extends PostEvent {
  const PostUpdated({
    required this.id,
    this.title,
    this.author,
    this.article,
    this.imageFile,
  });

  final int id;
  final String? title;
  final String? author;
  final String? article;
  final dynamic imageFile;

  @override
  List<Object?> get props => [id, title, author, article, imageFile];
}

class PostDeleted extends PostEvent {
  const PostDeleted(this.id);
  final int id;
  @override
  List<Object?> get props => [id];
}
