import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
