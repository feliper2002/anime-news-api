import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/core/error/failure.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_state.dart';
import 'package:intoxianimeapi/home/presenter/models/anime_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.client}) : super(const PostState()) {
    on<PostEvent>(_onFetch);
  }

  final Dio client;

  Future<void> _onFetch(PostEvent event, Emitter<PostState> emit) async {
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      final posts = await _fetchPosts(2);
      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false,
            ));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  List<AnimePost> posts = <AnimePost>[];
  Future<List<AnimePost>> _fetchPosts([int page = 1, int perPage = 10]) async {
    const path = 'https://www.intoxianime.com/?rest_route=/wp/v2';

    final response =
        await client.get('$path/posts&page=$page&per_page=$perPage');

    for (var post in response.data) {
      final animePost = AnimePost.fromMap(post);
      posts.add(animePost);
    }
    try {
      return posts;
    } catch (e) {
      throw NotFoundFailure("Não foi possível retornar a lista de posts.");
    }
  }
}
