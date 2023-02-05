import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:punk_os/kit/markdown/editor/block/editor_block.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_page_controller.dart';

class WikiPage extends StatefulWidget {
  const WikiPage({super.key});

  @override
  State<WikiPage> createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  late WikiPageController controller;

  Wiki? wiki;

  @override
  void initState() {
    super.initState();
    controller = WikiPageController();
    controller.addListener(reload);
    Future(() {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      wiki = arguments['wiki'];
      controller.setWiki(wiki!);
    });
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
        blocks.add(Stack(
          children: [
            EditorBlock(controller.blocks[i],
                key: UniqueKey(),
                onUpdate: (newContent) => controller.onUpdate(i, newContent)),
            Positioned(
                bottom: 8,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MaterialButton(
                        onPressed: () => null, child: const Text('上新块')),
                    MaterialButton(
                        onPressed: () => null, child: const Text('下新块')),
                    MaterialButton(
                        onPressed: () =>
                            controller.onSave(controller.blocks[i]),
                        child: const Text('保存')),
                  ],
                ))
          ],
        ));
      } else {
        blocks.add(GestureDetector(
            onTap: () => setState(() {
                  controller.currentEdit = i;
                }),
            child: Markdown(
              data: controller.blocks[i].content,
              shrinkWrap: true,
            )));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(wiki?.name ?? ""),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => blocks[index],
        itemCount: blocks.length,
      ),
    );
  }
}
