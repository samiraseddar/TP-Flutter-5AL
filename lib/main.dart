import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_note_seddar/posts_screen/posts_screen.dart';
import 'package:tp_note_seddar/shared/bloc/posts_bloc.dart';
import 'package:tp_note_seddar/shared/services/local_posts_data_source/fake_local_posts_data_source.dart';
import 'package:tp_note_seddar/shared/services/posts_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => PostsRepository(
          dataSource: FakeLocalPostsDataSource(),
        ),
        child: BlocProvider(
          create: (context) => PostsBloc(
            postsRepository: context.read<PostsRepository>(),
          )..add(GetAllPosts()),
          child: const PostsScreen(),
        ),
      ),
    );
  }
}