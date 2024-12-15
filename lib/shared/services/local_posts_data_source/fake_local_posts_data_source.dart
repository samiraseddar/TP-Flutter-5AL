import '../../models/post.dart';
import 'local_posts_data_source.dart';

class FakeLocalPostsDataSource implements LocalPostsDataSource {
  final List<Post> _fakePosts = [
    Post(id: '1', title: 'Post 1', description: 'Description du post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description du post 2'),
    Post(id: '3', title: 'Post 3', description: 'Description du post 3'),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post post) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(post);
    return post;
  }

  @override
  Future<Post> updatePost(Post newPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == newPost.id);
    if (index != -1) {
      _fakePosts[index] = newPost;
      return newPost;
    }
    throw Exception('Post not found');
  }
}
