import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_quill/flutter_quill.dart';
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

  @override
  Widget build(BuildContext context) {
    if (!init) return const CircularProgressIndicator();
    return Scaffold(
      appBar: AppBar(
        title: md.Text(wiki.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: onSave,
          ),
        ],
      ),
      body: Column(
        children: [
          QuillToolbar.basic(controller: _controller),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuillEditor.basic(
                  controller: _controller,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
