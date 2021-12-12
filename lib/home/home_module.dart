import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intoxianimeapi/home/domain/usecases/get_anime_post.dart';
import 'package:intoxianimeapi/home/external/datasource/anime_datasource.dart';
import 'package:intoxianimeapi/home/infra/repositories/anime_repository.dart';
import 'package:intoxianimeapi/home/presenter/content.page.dart';
import 'package:intoxianimeapi/home/presenter/home.page.dart';

import 'presenter/controller/anime_controller.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => AnimeDatasourceFTeam(i.get())),
        Bind((i) => AnimeRepositoryImpl(i.get())),
        Bind((i) => GetAnimePostImpl(i.get())),
        Bind((i) => AnimeController(i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => HomePage()),
        ChildRoute('/content', child: (_, args) => ContentPage()),
      ];
}
