import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intoxianimeapi/home/domain/usecases/get_anime_post.dart';
import 'package:intoxianimeapi/home/infra/repositories/anime_repository.dart';

import 'controller/anime_controller.dart';
import 'models/anime_model.dart';
import 'widgets/post_container.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Modular.get<AnimeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Anime Posts - API'),
          backgroundColor: Colors.black),
      body: FutureBuilder<List<AnimePost>>(
          future: controller.getAnimePost(),
          builder: (_, AsyncSnapshot<List<AnimePost>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final post = snapshot.data![index];
                    return PostContainer(
                      post: post,
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
          }),
    );
  }
}
