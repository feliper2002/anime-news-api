import 'package:dio/dio.dart';
import 'package:intoxianimeapi/core/error/failure.dart';
import 'package:intoxianimeapi/home/presenter/models/anime_model.dart';

abstract class AnimeDatasource {
  Future<List<AnimePost>> getAnimePost([int page, int perPage]);
}

List<AnimePost> posts = <AnimePost>[];

class AnimeDatasourceFTeam implements AnimeDatasource {
  final Dio client;

  AnimeDatasourceFTeam(this.client);

  @override
  Future<List<AnimePost>> getAnimePost([int page = 1, int perPage = 10]) async {
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
