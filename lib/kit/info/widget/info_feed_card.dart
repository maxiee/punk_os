import 'package:flutter/material.dart';
import 'package:punk_os/kit/info/info_service.dart';

class InfoFeedCard extends StatelessWidget {
  const InfoFeedCard(this.info, {super.key});

  final Info info;

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
            ]),
      ),
    );
  }

  List<Widget> parseTitle() {
    List<Widget> ret = [];
    if (info.titleFC.isEmpty) {
      ret.add(Text(info.title,
                  style: TextStyle(
                      fontSize: 20, color: Colors.blue.shade900))); 
    } else {
      for (final fc in info.titleFC) {
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
