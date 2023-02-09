import 'package:flutter/material.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';

class MarkButton extends StatefulWidget {
  const MarkButton(this.wiki, this.onWikiChanged, {super.key});

  final Wiki wiki;
  final Function(Wiki wiki) onWikiChanged;

  @override
  State<MarkButton> createState() => _MarkButtonState();
}

class _MarkButtonState extends State<MarkButton> {
  late Wiki wiki;

  @override
  void initState() {
    super.initState();
    wiki = widget.wiki;
  }

  onToggleMark() {
    setState(() {
      wiki = toggleWikiMark(wiki);
    });
    widget.onWikiChanged(wiki);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onToggleMark,
        icon: Icon(wiki.mark == 1 ? Icons.star : Icons.star_border,
            color: Colors.yellow));
  }
}
