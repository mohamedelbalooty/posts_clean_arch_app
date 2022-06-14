import 'package:equatable/equatable.dart';
import '../../../domain_layer/entities/post_entity.dart';

abstract class PostsStates extends Equatable {
  const PostsStates();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PostsInitialState extends PostsStates {}

class PostsLoadingState extends PostsStates {}

class PostsLoadedState extends PostsStates {
  final List<Post> posts;

  const PostsLoadedState({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class PostsErrorState extends PostsStates {
  final String message;

  const PostsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
