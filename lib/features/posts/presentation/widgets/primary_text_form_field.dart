import 'package:flutter/material.dart';

class PrimaryTextFormField extends StatelessWidget {
  const PrimaryTextFormField({
    Key? key,
    required this.controller,
    required this.text,
    this.multiLines = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final bool multiLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          return value!.isEmpty ? '$text Can\'t be empty' : null;
        },
        decoration: InputDecoration(hintText: text),
        minLines: multiLines ? 6 : 1,
        maxLines: multiLines ? 6 : 1,
      ),
    );
  }
}
