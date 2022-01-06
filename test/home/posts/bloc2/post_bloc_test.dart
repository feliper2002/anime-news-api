import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_state.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_bloc.dart';
import 'package:intoxianimeapi/home/posts/models/anime_model.dart';
import 'package:intoxianimeapi/home/posts/repository/anime_repository.dart';
import 'package:mocktail/mocktail.dart';

class AnimeRepositoryMock extends Mock implements AnimeRepositoryFTeam {}

void main() {
  late AnimeRepositoryFTeam repository;

  blocTest<PostBloc, PostState>(
    'Should return a SucessPostState when InitialEvent was sent',
    build: () {
      repository = AnimeRepositoryMock();

      when(() => repository.getAnimePost()).thenAnswer(
        (_) async => <AnimePost>[],
      );

      return PostBloc(repository);
    },
    act: (bloc) => bloc.add(InitialEvent()),
    expect: () => [
      isA<LoadPostState>(),
      isA<SucessPostState>(),
    ],
    verify: (_) {
      verify(() => repository.getAnimePost(1, 10)).called(1);
    },
  );

  blocTest<PostBloc, PostState>(
    'Should return a SucessPostState when PostParameters was sent',
    build: () {
      repository = AnimeRepositoryMock();

      when(() => repository.getAnimePost(1, 10)).thenAnswer(
        (_) async => <AnimePost>[],
      );

      return PostBloc(repository);
    },
    act: (bloc) => bloc.add(PostParameters()),
    expect: () => [
      isA<SucessPostState>(),
    ],
  );
}
