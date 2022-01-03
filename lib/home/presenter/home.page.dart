import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_state.dart';
import 'widgets/post_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Anime Posts - API'),
          backgroundColor: Colors.black),
      body: BlocProvider(
        create: (_) => PostBloc(client: Dio())..add(PostEvent()),
        child: const AnimeList(),
      ),
    );
  }
}

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (_, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          case PostStatus.success:
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ListView.builder(
                itemCount: state.posts.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  final post = state.posts[index];
                  return PostContainer(
                    post: post,
                  );
                },
              ),
            );
          default:
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
        }
      },
    );
  }
}
