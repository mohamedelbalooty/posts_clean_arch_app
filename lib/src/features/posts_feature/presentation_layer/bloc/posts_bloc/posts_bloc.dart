import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/src/features/posts_feature/domain_layer/use_cases/get_posts_use_case.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/posts_bloc/posts_event.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/posts_bloc/posts_state.dart';
import '../../../../../core/errors/failures_handling.dart';

class PostsBloc extends Bloc<PostsEvent, PostsStates> {
  final GetAllPostsUseCase getAllPosts;
  final FailuresHandling failuresHandling;

  PostsBloc({required this.getAllPosts, required this.failuresHandling})
      : super(PostsInitialState()) {
    on<PostsEvent>((PostsEvent event, Emitter emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(PostsLoadingState());
        final result = await getAllPosts();
        result.fold((left) {
          emit(
            PostsErrorState(
              message: failuresHandling.onHandlingFailures(failure: left),
            ),
          );
        }, (right) {
          emit(PostsLoadedState(posts: right));
        });
      }
    });
  }
}
