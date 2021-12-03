import 'package:dio/dio.dart';
import 'package:intoxianimeapi/home/models/anime_post.dart';

abstract class AnimeRepository {
  Future<List<AnimePost>> getAnimePost([String? page, String? itemPerPage]);
}

class AnimeRepositoryImpl implements AnimeRepository {
  final Dio client;

  final path = 'https://www.intoxianime.com/?rest_route=/wp/v2';

  AnimeRepositoryImpl(this.client);
  @override
  Future<List<AnimePost>> getAnimePost(
      [String? page = '1', String? itemPerPage = '10']) async {
    final response =
        await client.get('$path/posts&page=$page&per_page=$itemPerPage');

    List<AnimePost> posts = <AnimePost>[];

    for (var post in response.data) {
      final animePost = AnimePost.fromMap(post);
      posts.add(animePost);
    }
    try {
      return posts;
    } catch (e) {
      throw "Não foi possível retornar a lista de posts.";
    }
  }
}
