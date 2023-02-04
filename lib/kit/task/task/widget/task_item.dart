import 'package:flutter/material.dart';
import 'package:punk_os/kit/task/task/task_model.dart';
import 'package:punk_os/kit/task/task/task_service.dart';

ListTile taskListTile(BuildContext context, Task t) {
  List<Widget> subtitle = [];
  if (t.deadline != null) subtitle.add(Badge(label: Text('截至${t.deadline}')));
  return ListTile(
    title: Text(t.name),
    subtitle: Wrap(children: subtitle),
    trailing: t.finish == Task.kFinish
        ? IconButton(
            onPressed: () => toggleTask(t),
            icon: const Icon(Icons.check_circle, color: Colors.green))
        : IconButton(
            onPressed: () => toggleTask(t),
            icon: const Icon(
              Icons.check_circle_outline,
            )),
    onTap: () =>
        Navigator.of(context).pushNamed('/task_detail', arguments: {'task': t}),
  );
}
