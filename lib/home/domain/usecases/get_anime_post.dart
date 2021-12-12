import 'package:dartz/dartz.dart';
import 'package:intoxianimeapi/core/error/failure.dart';
import 'package:intoxianimeapi/home/presenter/models/anime_model.dart';

import '../../infra/repositories/anime_repository.dart';

abstract class GetAnimePost {
  Future<Either<Failure, List<AnimePost>>> call([int page, int perPage]);
}

class GetAnimePostImpl implements GetAnimePost {
  final AnimeRepository repository;

  GetAnimePostImpl(this.repository);

  @override
  Future<Either<Failure, List<AnimePost>>> call(
      [int page = 1, int perPage = 10]) async {
    Map<String, dynamic> errors = {};

    if (page < 1 || page > 100) {
      errors.putIfAbsent(
          'page', () => 'A página informada não foi encontrada!');
    }

    if (perPage <= 0) {
      errors.putIfAbsent(
          'perPage', () => 'Informe um valor que seja superior a zero!');
    }

    if (errors.entries.isNotEmpty) {
      return Left(
        UnprocessableEntityFailure("", errors),
      );
    }

    return repository.getAnimePost(page, perPage);
  }
}
