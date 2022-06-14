import 'package:dartz/dartz.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostLocalDataSourceImplWithSharedPreferences implements PostLocalDataSource{
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    // TODO: implement cachedPosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}

class PostLocalDataSourceImplWithSqlite implements PostLocalDataSource{
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    // TODO: implement cachedPosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}