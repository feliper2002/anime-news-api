import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_state.dart';
import 'package:intoxianimeapi/home/posts/models/anime_model.dart';
import 'package:intoxianimeapi/home/posts/repository/anime_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.repository) : super(InitialPostState()) {
    on<InitialEvent>(_getInitialPosts);
    on<PostParameters>(_getPosts);
  }

  final AnimeRepository repository;

  int page = 1;
  incrementPage() => page++;

  late List<AnimePost> posts;

  Future<void> _getInitialPosts(
      InitialEvent event, Emitter<PostState> emit) async {
    emit(LoadPostState());
    try {
      posts = await repository.getAnimePost();
      emit(SucessPostState(posts));
    } catch (e) {
      emit(ErrorPostState(e.toString()));
    }
  }

  Future<void> _getPosts(PostParameters event, Emitter<PostState> emit) async {
    if (page < 200) incrementPage();
    late List<AnimePost> newPosts;
    try {
      newPosts = await repository.getAnimePost(page);
      if (newPosts.isNotEmpty) {
        posts.addAll(newPosts);
      }
      emit(SucessPostState(posts));
    } catch (e) {
      if (newPosts.isEmpty) {
        emit(ErrorPostState(e.toString()));
      }
    }
  }
}
