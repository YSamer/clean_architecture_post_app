import 'package:clean_architecture_post_app/features/posts/presentation/bloc/post_actions/post_actions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final int postId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<PostActionsBloc>(context)
                .add(DeletePostEvent(postId: postId));
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
