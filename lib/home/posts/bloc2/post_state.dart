// inicial
// sucesso
// erro
// carregamento

import 'package:intoxianimeapi/home/posts/models/anime_model.dart';

abstract class PostState {}

class InitialPostState extends PostState {}

class SucessPostState extends PostState {
  final List<AnimePost> animePosts;

  SucessPostState(this.animePosts);
}

class ErrorPostState extends PostState {
  final String message;

  ErrorPostState(this.message);
}

class LoadPostState extends PostState {}
