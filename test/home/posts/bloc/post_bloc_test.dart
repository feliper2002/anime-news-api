import 'package:flutter_test/flutter_test.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_state.dart';
import 'package:intoxianimeapi/home/posts/models/anime_model.dart';
import 'package:intoxianimeapi/home/posts/repository/anime_repository.dart';
import 'package:mocktail/mocktail.dart';

class AnimeRepositoryMock extends Mock implements AnimeRepositoryFTeam {}

void main() {
  final repository = AnimeRepositoryMock();
  final bloc = PostBloc(repository: repository);

  test(
      'Should expect values from BLoC: State, Post and Page. Simulating the page increment.',
      () async {
    when(() => repository.getAnimePost())
        .thenAnswer((_) async => <AnimePost>[]);

    bloc.add(PostEventInitial());

    expect(bloc.state, isA<PostState>());
    expect(bloc.posts, isA<List<AnimePost>>());
    expect(bloc.page, equals(1));

    bloc.incrementPage();
    bloc.add(PostEventFetchMorePosts());
    expect(bloc.state, isA<PostState>());
    expect(bloc.posts, isA<List<AnimePost>>());
    expect(bloc.page, greaterThan(1));
  });
}
