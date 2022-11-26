// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_actions_bloc.dart';

abstract class PostActionsState extends Equatable {
  const PostActionsState();

  @override
  List<Object> get props => [];
}

class PostActionsInitial extends PostActionsState {}

class LoadingActionsState extends PostActionsState {}

class ErrorActionsState extends PostActionsState {
  final String message;
  const ErrorActionsState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class MessageActionsState extends PostActionsState {
  final String message;
  const MessageActionsState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
