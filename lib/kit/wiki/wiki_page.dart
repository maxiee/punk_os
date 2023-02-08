import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:punk_os/kit/quill/wiki_alias.dart';
import 'package:punk_os/kit/quill/wiki_link.dart';
import 'package:punk_os/kit/wiki/alias/alias_model.dart';
import 'package:punk_os/kit/wiki/alias/alias_service.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';

class WikiPage extends StatefulWidget {
  const WikiPage({super.key});

  @override
  State<WikiPage> createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  bool init = false;

  late QuillController _controller;
  late Wiki wiki;
  List<WikiAlias> alias = [];

  @override
  void initState() {
    super.initState();
    Future(() {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      wiki = arguments['wiki'];
      if (wiki.content.isNotEmpty) {
        _controller = QuillController(
            document: Document.fromJson(jsonDecode(wiki.content)),
            selection: const TextSelection.collapsed(offset: 0));
      } else {
        _controller = QuillController.basic();
      }
      setState(() {
        loadAlias();
        init = true;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  onSave() {
    wiki.content = jsonEncode(_controller.document.toDelta().toJson());
    wiki.contentStr = _controller.document.toPlainText();
    wiki = saveWiki(wiki);
  }

  loadAlias() {
    alias = getWikiAliasByWikiUUID(wiki.uuid!);
  }

  @override
  Widget build(BuildContext context) {
    if (!init) return const CircularProgressIndicator();
    List<String> names = [wiki.name];
    names.addAll(alias.map((e) => e.name));
    return Scaffold(
      appBar: AppBar(
        title: md.Text(names.join('/')),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: onSave,
          ),
        ],
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              QuillToolbar.basic(
                  showAlignmentButtons: true,
                  customButtons: [
                    quillWikiLinkButton(context, _controller),
                    quillWikiAliasButton(
                        context,
                        wiki,
                        () => setState(() {
                              loadAlias();
                            })),
                  ],
                  embedButtons:
                      FlutterQuillEmbeds.buttons(showFormulaButton: true),
                  controller: _controller),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillEditor(
                      controller: _controller,
                      scrollController: ScrollController(),
                      scrollable: true,
                      focusNode: FocusNode(),
                      autoFocus: true,
                      readOnly: false,
                      expands: false,
                      padding: EdgeInsets.zero,
                      keyboardAppearance: Brightness.light,
                      embedBuilders: FlutterQuillEmbeds.builders(),
                      onLaunchUrl: (url) {
                        print(url);
                        if (url.contains('wiki://')) {
                          String uuid = url
                              .replaceAll('wiki://', '')
                              .replaceAll('https://', '');
                          Navigator.of(context).pushNamed("/wiki",
                              arguments: {'wiki': getWikiByUUID(uuid)});
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
