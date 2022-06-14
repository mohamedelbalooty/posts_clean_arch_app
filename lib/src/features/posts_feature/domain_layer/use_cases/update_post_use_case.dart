import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class UpdatePostUseCase{
  final PostRepository repository;
  UpdatePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }

}