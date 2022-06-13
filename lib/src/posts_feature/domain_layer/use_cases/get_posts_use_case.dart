import 'package:dartz/dartz.dart';
import 'package:tdd_app/src/posts_feature/domain_layer/repositories/post_repository.dart';
import '../../../../core/failures.dart';
import '../entities/post_entity.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
