import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_state.dart';
import 'package:intoxianimeapi/home/posts/database/anime_database.dart';
import 'package:intoxianimeapi/home/posts/widgets/post_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Anime Posts - API'),
          backgroundColor: Colors.black),
      body: BlocProvider(
        // Dependency Injection
        create: (_) => PostBloc(datasource: AnimeDatasourceFTeam(Dio()))
          ..add(PostEventInitial()),
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
  final controller = ScrollController();

  bool get _isBottom {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostEventFetchMorePosts());
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (_, state) {
        switch (state.status) {
          case PostStatus.failure:
            return _loader();
          case PostStatus.success:
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ListView.builder(
                controller: controller,
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
            return _loader();
        }
      },
    );
  }

  _loader() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
