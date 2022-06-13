import 'package:dartz/dartz.dart';
import 'package:tdd_app/src/posts_feature/domain_layer/entities/post_entity.dart';
import '../../../../core/failures.dart';

abstract class PostRepository{
  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> createPost(Post post);
}