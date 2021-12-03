import 'package:flutter/material.dart';
import 'package:intoxianimeapi/home/controllers/anime_controller.dart';
import 'package:intoxianimeapi/home/models/anime_post.dart';
import 'package:intoxianimeapi/home/widgets/post_container.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = AnimeController();

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
