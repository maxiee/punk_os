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
      info.titleFC = newCut;
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
              if (info.site.isNotEmpty) Text(info.site),
              const SizedBox(height: 8),
              Text(info.updated.toString(), style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Wrap(children: parseTitle()),
              const SizedBox(height: 8),
              Text(info.description, style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              Container(height: 1, color: Colors.grey.shade300),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(onPressed: () => onClickAddWord(context), child: const Text('登记新词'))
                ],)
            ]),
      ),
    );
  }

  List<Widget> parseTitle() {
    List<Widget> ret = [];
    if (widget.info.titleFC.isEmpty) {
      ret.add(Text(widget.info.title,
                  style: TextStyle(
                      fontSize: 20, color: Colors.blue.shade900))); 
    } else {
      for (final fc in widget.info.titleFC) {
        ret.add(Text(fc,
                  style: TextStyle(
                      fontSize: 20, color: Colors.blue.shade900)));
        ret.add(Text('/', style: TextStyle(
                      fontSize: 20, color: Colors.purple.shade200)));
      }
    }
    return ret;
  }
}
