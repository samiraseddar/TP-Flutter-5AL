import '../../models/post.dart';

abstract class LocalPostsDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(Post post);
  Future<Post> updatePost(Post post);
}