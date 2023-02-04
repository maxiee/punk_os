import 'package:flutter/material.dart';

class DashboardList extends StatelessWidget {
  const DashboardList({super.key, required this.items, required this.title});

  final String title;
  final List<ListTile> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.blue)),
            ...items
          ],
        ),
      ),
    );
  }
}
