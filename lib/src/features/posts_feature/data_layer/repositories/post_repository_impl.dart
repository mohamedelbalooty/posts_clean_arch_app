import 'package:dartz/dartz.dart';
import 'package:tdd_app/src/core/errors/exceptions.dart';
import 'package:tdd_app/src/features/posts_feature/data_layer/models/post_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain_layer/entities/post_entity.dart';
import '../../domain_layer/repositories/post_repository.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';

typedef DeleteOrUpdateOrCreate = Future<Unit> Function();

class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final posts = await remoteDataSource.getAllPosts();
        await localDataSource.cachePosts(posts);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedPosts = await localDataSource.getCachedPosts();
        return Right(cachedPosts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> createPost(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _organizeFutureFunction(() {
      return remoteDataSource.createPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _organizeFutureFunction(() {
      return remoteDataSource.delete(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel =
        PostModel(id: post.id!, title: post.title, body: post.body);
    return await _organizeFutureFunction(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _organizeFutureFunction(
      DeleteOrUpdateOrCreate deleteOrUpdateOrCreatePost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrCreatePost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
