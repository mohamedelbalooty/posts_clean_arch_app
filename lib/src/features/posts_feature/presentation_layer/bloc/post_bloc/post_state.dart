import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable{
  const PostState();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PostInitialState extends PostState{}

class PostLoadingState extends PostState{}

class PostSuccessState extends PostState{
  final String message;
  const PostSuccessState({required this.message});
  @override
  List<Object?> get props => [message];
}

class PostErrorState extends PostState{
  final String message;
  const PostErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
