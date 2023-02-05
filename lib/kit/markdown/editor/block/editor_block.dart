import 'package:flutter/material.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

class EditorBlock extends StatefulWidget {
  const EditorBlock(this.initContent,
      {super.key, this.onUpdate, this.onSubmit});

  final String initContent;
  final Function(String)? onUpdate;
  final Function()? onSubmit;

  @override
  State<EditorBlock> createState() => _EditorBlockState();
}

class _EditorBlockState extends State<EditorBlock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MarkdownTextInput(
        widget.onUpdate!,
        widget.initContent,
        maxLines: 5,
      ),
      Positioned(
          right: 0,
          bottom: 8,
          child: MaterialButton(
              onPressed: widget.onSubmit, child: const Text("Save"))),
    ]);
  }
}
