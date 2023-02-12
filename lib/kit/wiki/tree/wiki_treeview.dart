import 'package:flutter/material.dart';
import 'package:punk_os/kit/quill/wiki_link.dart';
import 'package:punk_os/kit/wiki/link/link_model.dart';
import 'package:punk_os/kit/wiki/link/link_service.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
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

  Widget refresh(List<Wiki> wikis, {level = 0}) {
    List<Widget> ret = [];
    for (Wiki wiki in wikis) {
      ret.add(InkWell(
        onTap: () {
          if (wiki.uuid! == widget.wiki.uuid!) return;
          Navigator.of(context).pushNamed("/wiki", arguments: {'wiki': wiki});
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(prefixName(level) + wiki.name),
        ),
      ));
      ret.add(refresh(getWikiChildren(wiki.uuid!), level: level + 1));
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

  void onLinkWiki() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (ctx) => const WikiSearchPage(initText: "", initLink: "")))
        .then((wiki) {
      // name uuid content
      wiki as Tuple3<String, String, String>;
      setState(() {
        saveWikiLink(WikiLink(fromUUID: widget.wiki.uuid!, toUUID: wiki.item2));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('wiki 层级', style: TextStyle(fontWeight: FontWeight.bold)),
        refresh([widget.wiki], level: 0),
        const SizedBox(height: 10),
        MaterialButton(onPressed: onLinkWiki, child: const Text('链接Wiki'))
      ],
    );
  }
}
