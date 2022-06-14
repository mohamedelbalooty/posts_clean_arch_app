import 'package:equatable/equatable.dart';
import '../../../domain_layer/entities/post_entity.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreatePostEvent extends PostEvent {
  final Post post;

  const CreatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends PostEvent {
  final Post post;

  const UpdatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends PostEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}
