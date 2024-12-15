import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_note_seddar/posts_screen/widgets/post_create_screen.dart';
import 'package:tp_note_seddar/posts_screen/widgets/post_detail_screen.dart';
import 'package:tp_note_seddar/posts_screen/widgets/post_list_item.dart';

import '../shared/bloc/posts_bloc.dart';
import '../shared/models/post.dart';
class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              return IconButton(
                onPressed: state.isProcessing
                    ? null
                    : () => context.read<PostsBloc>().add(GetAllPosts()),
                icon: const Icon(Icons.refresh),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Une erreur s\'est produite',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<PostsBloc>().add(GetAllPosts()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          if (state.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.post_add,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun post disponible',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _navigateToCreatePost(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Créer un post'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<PostsBloc>().add(GetAllPosts());
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: state.posts.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostListItem(
                  post: post,
                  onTap: () => _navigateToPostDetail(context, post),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state.isProcessing
                ? null
                : () => _navigateToCreatePost(context),
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  void _navigateToCreatePost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<PostsBloc>(),
          child: const PostCreateScreen(),
        ),
      ),
    );
  }

  void _navigateToPostDetail(BuildContext context, Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<PostsBloc>(),
          child: PostDetailScreen(post: post),
        ),
      ),
    );
  }
}