import 'package:intoxianimeapi/home/posts/models/anime_model.dart';

enum PostStatus { initial, success, failure }

class PostState {
  final PostStatus status;
  final List<AnimePost> posts;
  final bool hasReachedMax;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <AnimePost>[],
    this.hasReachedMax = false,
  });

  PostState copyWith({
    PostStatus? status,
    List<AnimePost>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
