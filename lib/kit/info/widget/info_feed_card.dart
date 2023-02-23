import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:punk_os/kit/info/info_service.dart';

class InfoFeedCard extends StatefulWidget {
  const InfoFeedCard(this.info, {super.key});

  final Info info;

  @override
  State<InfoFeedCard> createState() => _InfoFeedCardState();
}

class _InfoFeedCardState extends State<InfoFeedCard> {
  late Info info;
  final likeWordCache = <String>{};

  @override
  initState() {
    super.initState();
    info = widget.info;
  }

  onClickAddWord(BuildContext context) async {
    final input = await prompt(context, title: const Text('输入登记词'));
    if (input == null || input.isEmpty) return;
    await addWord(input);
    final newCut = await cut(info.title);
    setState(() {
      info.like = info.like + 1;
      info.titleFC = newCut;
    });
  }

  onClickLikeWord(String word) async {
    if (likeWordCache.contains(word)) return;
    await likeWord(word);
    setState(() {
      info.like = info.like + 1;
      likeWordCache.add(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                if (info.site_img.isNotEmpty)
                  CircleAvatar(
                      radius: 18,
                      child: ClipOval(
                        child: Image.file(
                            File(info.site_img.replaceFirst('file://', ''))),
                      )),
                if (info.site_img.isNotEmpty) const SizedBox(width: 8),
                if (info.site.isNotEmpty) Text(info.site)
              ]),
              const SizedBox(height: 8),
              Text(info.updated.toString(),
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Wrap(children: parseTitle()),
              const SizedBox(height: 8),
              Text(info.description,
                  style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              if (info.images.isNotEmpty)
                Wrap(
                    children: info.images
                        .map((e) => Container(
                          width: MediaQuery.of(context).size.width * 0.9 / info.images.length,
                          height: 200,
                            child: Image.file(
                                File(e.replaceFirst('file://', '')), fit: BoxFit.fitWidth,)))
                        .toList()),
              Container(height: 1, color: Colors.grey.shade300),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      onPressed: () => onClickAddWord(context),
                      child: const Text('登记新词'))
                ],
              )
            ]),
      ),
    );
  }

  List<Widget> parseTitle() {
    List<Widget> ret = [];
    ret.add(Text(info.like.toString(),
        style: const TextStyle(fontSize: 20, color: Colors.purple)));
    ret.add(const SizedBox(width: 4));
    if (info.titleFC.isEmpty) {
      ret.add(Text(info.title,
          style: TextStyle(fontSize: 20, color: Colors.blue.shade900)));
    } else {
      for (final fc in info.titleFC) {
        ret.add(InkWell(
          onTap: () => onClickLikeWord(fc),
          child: Text(fc,
              style: TextStyle(
                  fontSize: 20,
                  color: likeWordCache.contains(fc)
                      ? Colors.red
                      : Colors.blue.shade900)),
        ));
        ret.add(Text('/',
            style: TextStyle(fontSize: 20, color: Colors.purple.shade200)));
      }
    }
    return ret;
  }
}
