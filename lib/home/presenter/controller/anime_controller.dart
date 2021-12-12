import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intoxianimeapi/core/error/failure.dart';
import 'package:intoxianimeapi/home/domain/usecases/get_anime_post.dart';

import '../models/anime_model.dart';

class AnimeController {
  final GetAnimePost _getAnimePostUsecase;

  AnimeController(this._getAnimePostUsecase);

  int page = 1;

  incrementPage() {
    page++;
  }

  List<AnimePost> posts = <AnimePost>[];
  Future<List<AnimePost>> getAnimePost([int page = 1, int perPage = 10]) async {
    final response = await _getAnimePostUsecase(page, perPage);

    response.fold((exception) {
      if (exception is UnprocessableEntityFailure) {
        if (exception.errors.containsKey('page')) {
          debugPrint(exception.message);
        }
        if (exception.errors.containsKey('perPage')) {
          debugPrint(exception.message);
        }
      } else if (exception is ServerFailure) {
        debugPrint(exception.message);
      } else if (exception is NotFoundFailure) {
        debugPrint(exception.message);
      }
    }, (_lista) {
      posts = _lista;
      return posts;
    });
    return posts;
  }
}
