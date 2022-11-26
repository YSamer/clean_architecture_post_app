import 'package:clean_architecture_post_app/features/posts/presentation/bloc/get_posts/get_posts_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/pages/add_edit_post_page.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/widgets/error_message_widget.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/widgets/loading_widget.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/widgets/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<GetPostsBloc, GetPostsState>(
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return const LoadingWidget();
            } else if (state is LoadedPostsState) {
              return RefreshIndicator(
                  onRefresh: () => onRefresh(context),
                  child: PostListWidget(posts: state.posts));
            } else if (state is ErrorPostsState) {
              return ErrorMessageWidget(message: state.message);
            }
            return const LoadingWidget();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const AddEditPostPage(isEdit: false)),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> onRefresh(BuildContext context) async {
    BlocProvider.of<GetPostsBloc>(context).add(RefreshPostsEvent());
  }
}
