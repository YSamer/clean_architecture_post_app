import 'package:clean_architecture_post_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/bloc/post_actions/post_actions_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/widgets/primary_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostFormWidget extends StatefulWidget {
  final Post? post;
  final bool isEdit;
  const PostFormWidget({
    Key? key,
    this.post,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<PostFormWidget> createState() => _PostFormWidgetState();
}

class _PostFormWidgetState extends State<PostFormWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void formAddEditAction() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final Post post = Post(
        id: widget.isEdit ? widget.post!.id : null,
        title: titleController.text,
        body: bodyController.text,
      );
      if (widget.isEdit) {
        BlocProvider.of<PostActionsBloc>(context).add(
          UpdatePostEvent(post: post),
        );
      } else {
        BlocProvider.of<PostActionsBloc>(context).add(
          AddPostEvent(post: post),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryTextFormField(
            text: 'Title',
            controller: titleController,
          ),
          PrimaryTextFormField(
            text: 'Body',
            controller: bodyController,
            multiLines: true,
          ),
          ElevatedButton.icon(
            onPressed: formAddEditAction,
            icon:
                widget.isEdit ? const Icon(Icons.edit) : const Icon(Icons.add),
            label: Text(widget.isEdit ? 'Edit' : 'Add'),
          ),
        ],
      ),
    );
  }
}
