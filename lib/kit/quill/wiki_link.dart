import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';
import 'package:flutter_quill/src/widgets/link.dart';

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
          builder: ((context) =>
              WikiSearchPage(initText: text!, initLink: link ?? ''))))
      .then((wiki) {
    if (wiki != null) {
      wiki as Wiki;
      String text = wiki.name;
      String link = 'wiki://${wiki.uuid}';

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
  TextEditingController controller = TextEditingController();
  List<Wiki> searchResults = [];

  @override
  void initState() {
    super.initState();
    if (widget.initLink.isNotEmpty && widget.initLink.startsWith('wiki://')) {
      String uuid = widget.initLink.replaceFirst('wiki://', '');
      Wiki? wiki = getWikiByName(uuid);
      if (wiki != null) {
        searchResults = [wiki];
      }
    }
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  searchName(String name) {
    setState(() {
      searchResults = searchWikiByName(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const md.Text("链接wiki")),
        body: Column(
          children: [
            const md.Text("输入Wiki名称"),
            TextField(controller: controller, onChanged: searchName),
            Expanded(
              child: ListView(
                  children: searchResults
                      .map((e) => ListTile(
                            title: md.Text(e.name),
                            subtitle: md.Text((e.contentStr.length > 50
                                    ? e.contentStr.substring(0, 50)
                                    : e.contentStr)
                                .replaceAll('\n', '')),
                            onTap: () => Navigator.of(context).pop(e),
                          ))
                      .toList()),
            ),
          ],
        ));
  }
}
