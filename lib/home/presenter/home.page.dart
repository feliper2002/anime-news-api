import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_bloc.dart';
import 'package:intoxianimeapi/home/posts/bloc/post_state.dart';
import 'widgets/post_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Anime Posts - API'),
          backgroundColor: Colors.black),
      body: BlocBuilder<PostBloc, PostState>(builder: (_, state) {
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
      }),
    );
  }
}
