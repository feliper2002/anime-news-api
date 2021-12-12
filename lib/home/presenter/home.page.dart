import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controller/anime_controller.dart';
import 'models/anime_model.dart';
import 'widgets/post_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<AnimeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Anime Posts - API'),
          backgroundColor: Colors.black),
      body: FutureBuilder<List<AnimePost>>(
          future: controller.getAnimePost(controller.page),
          builder: (_, AsyncSnapshot<List<AnimePost>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: NotificationListener<ScrollEndNotification>(
                  onNotification: (scrollEnd) {
                    var metrics = scrollEnd.metrics;
                    if (metrics.atEdge) {
                      if (metrics.pixels == 0) {
                      } else {
                        if (snapshot.connectionState == ConnectionState.done) {
                          setState(() {
                            controller.incrementPage();
                            debugPrint("Página ${controller.page}");
                          });
                        }
                      }
                    }
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: controller.posts.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      final post = snapshot.data![index];
                      return PostContainer(
                        post: post,
                      );
                    },
                  ),
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
