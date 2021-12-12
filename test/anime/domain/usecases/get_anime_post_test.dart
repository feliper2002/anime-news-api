import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intoxianimeapi/core/error/failure.dart';
import 'package:intoxianimeapi/home/domain/usecases/get_anime_post.dart';
import 'package:intoxianimeapi/home/infra/repositories/anime_repository.dart';
import 'package:intoxianimeapi/home/presenter/models/anime_model.dart';
import 'package:mockito/mockito.dart';

class AnimeRepositoryMock extends Mock implements AnimeRepositoryImpl {}

void main() {
  late AnimeRepositoryMock repository;
  late GetAnimePost usecase;

  repository = AnimeRepositoryMock();
  usecase = GetAnimePostImpl(repository);
  test('Should return a List of AnimePost', () async {
    final posts = <AnimePost>[
      AnimePost(title: "Pokémon BDSP"),
      AnimePost(title: "Novos animes anunciados"),
      AnimePost(title: "Pokémon BDSP"),
      AnimePost(title: "Novos animes anunciados"),
    ];

    when(() => repository.getAnimePost()).thenAnswer((_) async => Right(posts));

    var result = await usecase(1, 10);
    expect(result.fold(id, id), isA<List<AnimePost>>());
  });

  test('Should return an UnprocessableEntityFailure', () async {
    when(() => repository.getAnimePost()).thenThrow(UnprocessableEntityFailure);

    var result = await usecase(-10, 300);
    expect(result.fold(id, id), isA<UnprocessableEntityFailure>());

    result = await usecase(-10, -300);
    expect(result.fold(id, id), isA<UnprocessableEntityFailure>());

    result = await usecase(0, 0);
    expect(result.fold(id, id), isA<UnprocessableEntityFailure>());
  });
}
