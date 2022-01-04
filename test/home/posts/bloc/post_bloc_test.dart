import 'package:flutter_test/flutter_test.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_state.dart';
import 'package:intoxianimeapi/home/posts/database/anime_database.dart';
import 'package:intoxianimeapi/home/posts/models/anime_model.dart';
import 'package:mocktail/mocktail.dart';

class AnimeDatasourceMock extends Mock implements AnimeDatasourceFTeam {}

void main() {
  final datasource = AnimeDatasourceMock();
  final bloc = PostBloc(datasource: datasource);

  test(
      'Should expect values from BLoC: State, Post and Page. Simulating the page increment.',
      () async {
    when(() => datasource.getAnimePost())
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
