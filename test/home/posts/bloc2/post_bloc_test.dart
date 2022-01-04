import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_state.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_bloc.dart';
import 'package:intoxianimeapi/home/posts/repository/anime_repository.dart';
import 'package:mocktail/mocktail.dart';

class AnimeRepositoryMock extends Mock implements AnimeRepositoryFTeam {}

class DioMock extends Mock implements Dio {}

void main() {
  final client = DioMock();
  final repository = AnimeRepositoryFTeam(client);

  when(() => client.get(any())).thenAnswer(
    (_) async => Response(
      requestOptions: RequestOptions(
        path: '',
        data: {},
      ),
      statusCode: 200,
    ),
  );

  blocTest<PostBloc, PostState>(
    'Should return a SucessPostState when InitialEvent was sent',
    build: () => PostBloc(repository),
    act: (bloc) => bloc.add(InitialEvent()),
    expect: () => [
      isA<LoadPostState>(),
      isA<SucessPostState>(),
    ],
  );

  blocTest<PostBloc, PostState>(
    'Should return a SucessPostState when PostParameters was sent',
    build: () => PostBloc(repository),
    act: (bloc) => bloc.add(PostParameters()),
    expect: () => [
      isA<SucessPostState>(),
    ],
  );
}
