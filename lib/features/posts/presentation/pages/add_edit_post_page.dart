import 'package:clean_architecture_post_app/core/util/snackbar.dart';
import 'package:clean_architecture_post_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/bloc/post_actions/post_actions_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/widgets/loading_widget.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/widgets/post_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditPostPage extends StatelessWidget {
  final Post? post;
  final bool isEdit;
  const AddEditPostPage({super.key, this.post, this.isEdit = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Post' : 'AddPost')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<PostActionsBloc, PostActionsState>(
            listener: (context, state) {
              if (state is MessageActionsState) {
                showSnackBar(context: context, message: state.message);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: ((context) => const PostsPage()),
                  ),
                  (route) => false,
                );
              } else if (state is ErrorActionsState) {
                showSnackBar(
                  context: context,
                  message: state.message,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingActionsState) {
                return const LoadingWidget();
              }
              return PostFormWidget(post: post, isEdit: isEdit);
            },
          ),
        ),
      ),
    );
  }
}
