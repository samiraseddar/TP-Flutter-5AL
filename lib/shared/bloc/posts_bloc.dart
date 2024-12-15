import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_exception.dart';
import '../models/post.dart';
import '../services/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(const PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostsState> emit) async {
    try {
      emit(state.copyWith(status: PostsStatus.loading));
      final posts = await postsRepository.getAllPosts();
      emit(state.copyWith(
        status: PostsStatus.success,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        exception: PostsLoadException(),
      ));
    }
  }

  void _onCreatePost(CreatePost event, Emitter<PostsState> emit) async {
    try {
      emit(state.copyWith(status: PostsStatus.loading));
      await postsRepository.createPost(event.post);
      final posts = await postsRepository.getAllPosts();
      emit(state.copyWith(
        status: PostsStatus.success,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        exception: PostCreateException(),
      ));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<PostsState> emit) async {
    try {
      emit(state.copyWith(status: PostsStatus.loading));
      await postsRepository.updatePost(event.post);
      final posts = await postsRepository.getAllPosts();
      emit(state.copyWith(
        status: PostsStatus.success,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        exception: PostUpdateException(),
      ));
    }
  }
}