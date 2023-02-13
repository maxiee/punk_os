import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:punk_os/kit/quill/wiki_link.dart';
import 'package:punk_os/kit/wiki/link/link_model.dart';
import 'package:punk_os/kit/wiki/link/link_service.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';
import 'package:tuple/tuple.dart';

class WikiTreeView extends StatefulWidget {
  const WikiTreeView({super.key, required this.wiki});

  final Wiki wiki;

  @override
  State<WikiTreeView> createState() => _WikiTreeViewState();
}

class _WikiTreeViewState extends State<WikiTreeView> {
  @override
  void initState() {}

  /// Tuple2
  ///     Wiki：当前项的 Wiki
  ///     WikiLink：从 Widget.wiki 到当前项 Wiki 的 WikiLink
  Widget refresh(List<Tuple2<Wiki, WikiLink?>> wikis, {level = 0}) {
    List<Widget> ret = [];
    for (Tuple2<Wiki, WikiLink?> wiki in wikis) {
      ret.add(InkWell(
        onTap: () {
          if (wiki.item1.uuid! == widget.wiki.uuid!) return;
          Navigator.of(context)
              .pushNamed("/wiki", arguments: {'wiki': wiki.item1});
        },
        child: ContextMenuRegion(
          contextMenu: GenericContextMenu(buttonConfigs: [
            ContextMenuButtonConfig("添加子链接",
                onPressed: () => onLinkWiki(wiki.item1)),
            ContextMenuButtonConfig("删除链接", onPressed: () {
              if (wiki.item2 != null) {
                setState(() {
                  deleteWikiLink(wiki.item2!);
                });
              }
            })
          ]),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text(prefixName(level) + wiki.item1.name)),
          ),
        ),
      ));
      ret.add(Container(height: 1, color: Colors.grey.shade300));

      final childLinks = getWikiChildren(wiki.item1.uuid!);
      ret.add(refresh(
          childLinks.map((e) => Tuple2(getWikiByUUID(e.toUUID)!, e)).toList(),
          level: level + 1));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: ret,
    );
  }

  String prefixName(int level) {
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < level; i++) {
      sb.write('  ');
    }
    return sb.toString();
  }

  void onLinkWiki(Wiki from) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (ctx) => const WikiSearchPage(initText: "", initLink: "")))
        .then((wiki) {
      // name uuid content
      wiki as Tuple3<String, String, String>;
      setState(() {
        saveWikiLink(WikiLink(fromUUID: from.uuid!, toUUID: wiki.item2));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContextMenuOverlay(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('wiki 层级', style: TextStyle(fontWeight: FontWeight.bold)),
          refresh([Tuple2(widget.wiki, null)], level: 0),
          const SizedBox(height: 10),
          MaterialButton(
              onPressed: () => onLinkWiki(widget.wiki),
              child: const Text('链接Wiki'))
        ],
      ),
    );
  }
}
