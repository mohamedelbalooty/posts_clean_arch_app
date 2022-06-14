import 'package:dartz/dartz.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> delete(int postId);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> createPost(PostModel post);
}

class PostRemoteDataSourceImplWithHttp implements PostRemoteDataSource{

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> createPost(PostModel post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> delete(int postId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

}

class PostRemoteDataSourceImplWithDio implements PostRemoteDataSource{
  @override
  Future<Unit> createPost(PostModel post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> delete(int postId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

}