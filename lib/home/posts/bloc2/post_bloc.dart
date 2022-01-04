import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_state2.dart';
import 'package:intoxianimeapi/home/posts/repository/anime_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.repository) : super(InitialPostState()) {
    on<InitialEvent>(_getInitialPosts);
    on<PostParameters>(_getPosts);
  }

  final AnimeRepository repository;

  Future _getPosts(PostParameters event, Emitter<PostState> emit) async {
    try {
      final posts = await repository.getAnimePost();
      emit(SucessPostState(posts));
    } catch (e) {
      emit(ErrorPostState(e.toString()));
    }
  }

  Future _getInitialPosts(InitialEvent event, Emitter<PostState> emit) async {
    emit(LoadPostState());
    try {
      final posts = await repository.getAnimePost();
      emit(SucessPostState(posts));
    } catch (e) {
      emit(ErrorPostState(e.toString()));
    }
  }
}
