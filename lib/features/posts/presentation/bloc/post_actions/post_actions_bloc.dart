import 'package:clean_architecture_post_app/core/error/failures.dart';
import 'package:clean_architecture_post_app/core/functions/failure_to_message.dart';
import 'package:clean_architecture_post_app/core/strings/messages.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/user_cases/add_post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/user_cases/delete_post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/user_cases/update_post.dart';
part 'post_actions_event.dart';
part 'post_actions_state.dart';

class PostActionsBloc extends Bloc<PostActionsEvent, PostActionsState> {
  final AddPostUserCase addPost;
  final UpdatePostUserCase updatePost;
  final DeletePostUserCase deletePost;
  PostActionsBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(PostActionsInitial()) {
    on<PostActionsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingActionsState());
        final addAction = await addPost(event.post);
        emit(getActionResponse(addAction, addSuccessMessage));
      } else if (event is UpdatePostEvent) {
        emit(LoadingActionsState());
        final updateAction = await updatePost(event.post);
        emit(getActionResponse(updateAction, updateSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingActionsState());
        final deleteAction = await deletePost(event.postId);
        emit(getActionResponse(deleteAction, deleteSuccessMessage));
      }
    });
  }

  PostActionsState getActionResponse(
      Either<Failure, Unit> addAction, String message) {
    return addAction.fold(
        (failure) => ErrorActionsState(message: failureToMessage(failure)),
        (done) => MessageActionsState(message: message));
  }


}
