import 'package:flutter/material.dart';

class InfoFeedCard extends StatelessWidget {
  const InfoFeedCard(this.data, {super.key});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data['site'].isNotEmpty) Text(data['site']),
              const SizedBox(height: 8),
              Text(data['updated'], style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Text(data['title'],
                  style: TextStyle(
                      fontSize: 20, color: Colors.blue.shade900)),
              const SizedBox(height: 8),
              Text(data['description'], style: const TextStyle(color: Colors.black87)),
            ]),
      ),
    );
  }
}
