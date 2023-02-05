import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:punk_os/kit/markdown/editor/block/editor_block.dart';
import 'package:punk_os/kit/markdown/editor/editor_page_controller.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  EditorPageController controller = EditorPageController();

  @override
  void initState() {
    super.initState();
    if (controller.blocks.isEmpty) {
      controller.blocks.add("");
      controller.currentEdit = 0;
    }
    controller.addListener(reload);
  }

  @override
  dispose() {
    super.dispose();
    controller.removeListener(reload);
  }

  reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> blocks = [];
    for (int i = 0; i < controller.blocks.length; i++) {
      if (controller.currentEdit == i) {
        blocks.add(EditorBlock(controller.blocks[i],
            key: UniqueKey(),
            onUpdate: (newContent) => controller.onUpdate(i, newContent),
            onSubmit: () => controller.onSubmit(i)));
      } else {
        blocks.add(GestureDetector(
            onTap: () => setState(() {
                  controller.currentEdit = i;
                }),
            child: Markdown(
              data: controller.blocks[i],
              shrinkWrap: true,
            )));
      }
    }
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) => blocks[index],
        itemCount: blocks.length,
      ),
    );
  }
}
