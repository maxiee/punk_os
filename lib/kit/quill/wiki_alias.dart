import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:punk_os/kit/wiki/alias/alias_model.dart';
import 'package:punk_os/kit/wiki/alias/alias_service.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';

QuillCustomButton quillWikiAliasButton(BuildContext context, Wiki wiki) {
  return QuillCustomButton(
      icon: Icons.comment_outlined,
      onTap: () => _openWikiAliasPage(context, wiki));
}

void _openWikiAliasPage(BuildContext context, Wiki wiki) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => WikiAliasPage(wiki: wiki)));
}

class WikiAliasPage extends StatefulWidget {
  const WikiAliasPage({super.key, required this.wiki});

  final Wiki wiki;

  @override
  State<WikiAliasPage> createState() => _WikiAliasPageState();
}

class _WikiAliasPageState extends State<WikiAliasPage> {
  late TextEditingController controller;
  List<WikiAlias> searchResults = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    Future(reloadAlias);
  }

  void reloadAlias() {
    setState(() {
      searchResults = getWikiAliasByWikiUUID(widget.wiki.name);
    });
  }

  void onSaveNewAlias() {
    String newAlias = controller.text;
    if (newAlias.isEmpty) return;
    assert(widget.wiki.uuid != null);
    final alias = WikiAlias(name: newAlias, wikiuuid: widget.wiki.uuid!);
    saveWikiAlias(alias);
    controller.clear();
    reloadAlias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const md.Text('别名管理')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const md.Text('输入 Wiki 别名'),
        TextField(controller: controller),
        MaterialButton(onPressed: onSaveNewAlias, child: const md.Text('创建别名')),
        Expanded(
            child: ListView(
          children: searchResults
              .map((e) => ListTile(
                    title: md.Text(e.name),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => null),
                  ))
              .toList(),
        ))
      ]),
    );
  }
}
