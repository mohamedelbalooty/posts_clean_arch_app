import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/src/features/posts_feature/domain_layer/use_cases/create_post_use_case.dart';
import 'package:tdd_app/src/features/posts_feature/domain_layer/use_cases/delete_post_use_case.dart';
import 'package:tdd_app/src/features/posts_feature/domain_layer/use_cases/update_post_use_case.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/post_bloc/post_event.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/post_bloc/post_state.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/errors/failures_handling.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase createPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  final FailuresHandling failuresHandling;

  PostBloc(
      {required this.createPost,
      required this.updatePost,
      required this.deletePost,
      required this.failuresHandling})
      : super(PostInitialState()) {
    on<PostEvent>((PostEvent event, Emitter emit) async {
      if (event is CreatePostEvent) {
        emit(PostLoadingState());
        final Either<Failure, Unit> result = await createPost(event.post);
        emit(_handlingEitherResult(result, postCreatedSuccessfullyMessage));
      } else if (event is UpdatePostEvent) {
        emit(PostLoadingState());
        final Either<Failure, Unit> result = await updatePost(event.post);
        emit(_handlingEitherResult(result, postUpdatedSuccessfullyMessage));
      } else if (event is DeletePostEvent) {
        emit(PostLoadingState());
        final Either<Failure, Unit> result = await deletePost(event.postId);
        emit(_handlingEitherResult(result, postDeletedSuccessfullyMessage));
      }
    });
  }

  PostState _handlingEitherResult(
      Either<Failure, Unit> either, String message) {
    return either.fold((left) {
      return PostErrorState(
          message: failuresHandling.onHandlingFailures(failure: left));
    }, (right) {
      return PostSuccessState(message: message);
    });
  }

  static PostBloc get(BuildContext context) =>
      BlocProvider.of<PostBloc>(context);
}
