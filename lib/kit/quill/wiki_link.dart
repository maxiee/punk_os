import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:punk_os/kit/wiki/alias/alias_service.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';
import 'package:flutter_quill/src/widgets/link.dart';
import 'package:tuple/tuple.dart';

QuillCustomButton quillWikiLinkButton(
    BuildContext context, QuillController controller) {
  return QuillCustomButton(
      icon: Icons.dataset_linked,
      onTap: () => _openWikiLinkDialog(context, controller));
}

String? _getLinkAttributeValue(QuillController controller) {
  return controller.getSelectionStyle().attributes[Attribute.link.key]?.value;
}

void _openWikiLinkDialog(BuildContext context, QuillController controller) {
  final link = _getLinkAttributeValue(controller);
  final index = controller.selection.start;

  String? text;
  if (link != null) {
    // text should be the link's corresponding text, not selection
    final leaf = controller.document.querySegmentLeafNode(index).item2;
    if (leaf != null) {
      text = leaf.toPlainText();
    }
  }

  final len = controller.selection.end - index;
  text ??= len == 0 ? "" : controller.document.getPlainText(index, len);

  Navigator.of(context)
      .push(MaterialPageRoute(
          builder: (context) =>
              WikiSearchPage(initText: text!, initLink: link ?? '')))
      .then((wiki) {
    if (wiki != null) {
      wiki as Tuple3<String, String, String>;
      String text = wiki.item1;
      String link = 'wiki://${wiki.item2}';

      var index = controller.selection.start;
      var length = controller.selection.end - index;
      if (_getLinkAttributeValue(controller) != null) {
        final leaf = controller.document.querySegmentLeafNode(index).item2;
        if (leaf != null) {
          final range = getLinkRange(leaf);
          index = range.start;
          length = range.end - range.start;
        }
      }
      controller.replaceText(index, length, text, null);
      controller.formatText(index, text.length, LinkAttribute(link));
    }
  });
}

class WikiSearchPage extends StatefulWidget {
  const WikiSearchPage(
      {super.key, required this.initText, required this.initLink});

  final String initText;
  final String initLink;

  @override
  State<WikiSearchPage> createState() => _WikiSearchPageState();
}

class _WikiSearchPageState extends State<WikiSearchPage> {
  late TextEditingController controller;
  // tuple wiki name and uuid
  List<Tuple3<String, String, String>> searchResults = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initText);
    if (widget.initLink.isNotEmpty && widget.initLink.startsWith('wiki://')) {
      String uuid = widget.initLink.replaceFirst('wiki://', '');
      Wiki? wiki = getWikiByName(uuid);
      if (wiki != null) {
        searchResults = [Tuple3(wiki.name, wiki.uuid!, wiki.contentStr)];
      }
    } else {
      final wikis = searchWikiByName(widget.initText)
          .map((e) => Tuple3(e.name, e.uuid!, e.contentStr))
          .toList();
      final alias = searchWikiAliasByName(widget.initText)
          .map((e) => Tuple3(e.name, e.wikiuuid, ""));
      searchResults.clear();
      searchResults.addAll(wikis);
      searchResults.addAll(alias);
    }
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  searchName(String name) {
    setState(() {
      final wikis = searchWikiByName(name)
          .map((e) => Tuple3(e.name, e.uuid!, e.contentStr))
          .toList();
      final alias = searchWikiAliasByName(name)
          .map((e) => Tuple3(e.name, e.wikiuuid, ""));
      searchResults.clear();
      searchResults.addAll(wikis);
      searchResults.addAll(alias);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const md.Text("链接wiki")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const md.Text("输入Wiki名称"),
            TextField(controller: controller, onChanged: searchName),
            if (searchResults.isNotEmpty)
              Expanded(
                child: ListView(
                    children: searchResults
                        .map((e) => ListTile(
                              title: md.Text(e.item1),
                              subtitle: md.Text((e.item3.length > 50
                                      ? e.item3.substring(0, 50)
                                      : e.item3)
                                  .replaceAll('\n', '')),
                              onTap: () => Navigator.of(context).pop(e),
                            ))
                        .toList()),
              ),
            MaterialButton(
              onPressed: () {
                final wiki = saveWiki(
                    Wiki(name: controller.text, content: "", contentStr: ""));
                Navigator.of(context)
                    .pop(Tuple3(wiki.name, wiki.uuid!, wiki.contentStr));
              },
              child: md.Text("创建新wiki：${controller.text}"),
            )
          ],
        ));
  }
}
