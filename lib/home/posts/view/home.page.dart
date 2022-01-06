import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_event.dart';
import 'package:intoxianimeapi/home/posts/bloc2/post_state.dart';
import 'package:intoxianimeapi/home/posts/repository/anime_repository.dart';
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
        create: (_) =>
            PostBloc(AnimeRepositoryFTeam(Dio()))..add(InitialEvent()),
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
    if (_isBottom) context.read<PostBloc>().add(PostParameters());
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
        if (state is ErrorPostState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Opps! We´re having some error on loading...'),
              const CircularProgressIndicator(color: Colors.black),
              Text(state.message),
            ],
          );
        } else if (state is SucessPostState) {
          if (state.animePosts.isEmpty) {
            return const Center(child: Text('No more posts to see.'));
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: ListView.builder(
              controller: controller,
              itemCount: state.animePosts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                final post = state.animePosts[index];
                return PostContainer(
                  post: post,
                );
              },
            ),
          );
        } else {
          return _loader();
        }
      },
    );
  }

  _loader() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
