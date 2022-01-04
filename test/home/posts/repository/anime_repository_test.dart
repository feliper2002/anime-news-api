import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intoxianimeapi/home/posts/models/anime_model.dart';
import 'package:intoxianimeapi/home/posts/repository/anime_repository.dart';

void main() {
  final client = Dio();
  final repository = AnimeRepositoryFTeam(client);

  test('Should return a list of Anime Posts', () async {
    List<AnimePost> list = await repository.getAnimePost();

    expect(list.isNotEmpty, equals(true));
    expect(list.length, equals(10));
    expect(list.first, isA<AnimePost>());
  });
}
