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
              Text(info.title,
                  style: TextStyle(
                      fontSize: 20, color: Colors.blue.shade900)),
              const SizedBox(height: 8),
              Text(info.description, style: const TextStyle(color: Colors.black87)),
            ]),
      ),
    );
  }
}
