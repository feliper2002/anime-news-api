import 'package:dio/dio.dart';
import 'package:intoxianimeapi/home/models/anime_post.dart';
import 'package:intoxianimeapi/home/repository/anime_repository.dart';

class AnimeController {
  final dio = Dio();

  Future<List<AnimePost>> getAnimePost(
      [String? page = '1', String? itemPerPage = '10']) async {
    final repository = AnimeRepositoryImpl(dio);
    return await repository.getAnimePost(page, itemPerPage);
  }
}
