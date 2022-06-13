import 'package:dartz/dartz.dart';
import '../../../../core/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.createPost(post);
  }
}
