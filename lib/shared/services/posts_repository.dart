import '../models/post.dart';
import 'local_posts_data_source/local_posts_data_source.dart';

class PostsRepository {
  final LocalPostsDataSource dataSource;

  PostsRepository({required this.dataSource});

  Future<List<Post>> getAllPosts() async {
    return await dataSource.getAllPosts();
  }

  Future<Post> createPost(Post post) async {
    return await dataSource.createPost(post);
  }

  Future<Post> updatePost(Post post) async {
    return await dataSource.updatePost(post);
  }
}