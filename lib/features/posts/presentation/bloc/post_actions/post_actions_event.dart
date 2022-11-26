part of 'post_actions_bloc.dart';

abstract class PostActionsEvent extends Equatable {
  const PostActionsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends PostActionsEvent {
  final Post post;
  const AddPostEvent({
    required this.post,
  });

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends PostActionsEvent {
  final Post post;
  const UpdatePostEvent({
    required this.post,
  });

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends PostActionsEvent {
  final int postId;
  const DeletePostEvent({
    required this.postId,
  });

  @override
  List<Object> get props => [postId];
}
