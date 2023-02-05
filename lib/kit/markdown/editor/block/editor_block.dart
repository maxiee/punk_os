import 'package:flutter/material.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:punk_os/kit/block/block_model.dart';

class EditorBlock extends StatefulWidget {
  const EditorBlock(this.block, {super.key, this.onUpdate});

  final Block block;
  final Function(String)? onUpdate;

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
    return MarkdownTextInput(
      widget.onUpdate!,
      widget.block.content,
      maxLines: 5,
    );
  }
}
