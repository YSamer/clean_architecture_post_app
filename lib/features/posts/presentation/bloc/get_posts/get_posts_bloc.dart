import 'package:clean_architecture_post_app/core/functions/failure_to_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/user_cases/get_all_posts.dart';
import 'package:equatable/equatable.dart';
part 'get_posts_event.dart';
part 'get_posts_state.dart';

class GetPostsBloc extends Bloc<GetPostsEvent, GetPostsState> {
  final GetAllPostsUserCase getAllPosts;
  GetPostsBloc({required this.getAllPosts}) : super(GetPostsInitial()) {
    on<GetPostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final getPosts = await getAllPosts();
        getPosts.fold(
          (failure) {
            emit(ErrorPostsState(message: failureToMessage(failure)));
          },
          (posts) {
            emit(LoadedPostsState(posts: posts));
          },
        );
      }
    });
  }

}
