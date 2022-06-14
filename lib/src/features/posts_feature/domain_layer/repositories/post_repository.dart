import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';

abstract class PostRepository{
  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> createPost(Post post);
}