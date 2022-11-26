import 'package:clean_architecture_post_app/core/util/snackbar.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/bloc/post_actions/post_actions_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/widgets/delete_dialog.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

deletePost(BuildContext context, int postId) {
    return showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<PostActionsBloc, PostActionsState>(
          builder: (context, state) {
            if (state is LoadingActionsState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialog(postId: postId);
          },
          listener: (context, state) {
            if (state is MessageActionsState) {
              showSnackBar(context: context, message: state.message);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostsPage(),
                ),
                (route) => false,
              );
            } else if (state is ErrorActionsState) {
              Navigator.pop(context);
              showSnackBar(
                context: context,
                message: state.message,
                isError: true,
              );
            }
          },
        );
      },
    );
  }
