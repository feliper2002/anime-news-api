import 'package:dartz/dartz.dart';
import 'package:intoxianimeapi/core/error/failure.dart';
import 'package:intoxianimeapi/home/presenter/models/anime_model.dart';

import '../../external/datasource/anime_datasource.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<AnimePost>>> getAnimePost(
      [int page, int perPage]);
}

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeDatasource datasource;

  AnimeRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<AnimePost>>> getAnimePost(
      [int page = 1, int perPage = 10]) async {
    try {
      final data = await datasource.getAnimePost(page, perPage);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure("Erro ao conectar com o servidor."));
    }
  }
}
