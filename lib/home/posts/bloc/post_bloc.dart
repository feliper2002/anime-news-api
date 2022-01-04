import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_state.dart';
import 'package:intoxianimeapi/home/posts/models/anime_model.dart';
import 'package:intoxianimeapi/home/posts/repository/anime_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.repository}) : super(const PostState()) {
    on<PostEvent>(_onFetch);
  }

  AnimeRepository repository;

  int page = 1;

  incrementPage() => page++;

  List<AnimePost> posts = <AnimePost>[];
  Future<void> _onFetch(PostEvent event, Emitter<PostState> emit) async {
    try {
      if (state.status == PostStatus.initial) {
        final posts = await repository.getAnimePost();
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }

      if (page < 200) {
        incrementPage();
        final posts = await repository.getAnimePost(page);
        emit(posts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ));
      }
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
