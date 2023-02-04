import 'package:flutter/material.dart';
import 'package:punk_os/kit/task/task/task_model.dart';
import 'package:punk_os/kit/task/task/task_service.dart';

ListTile taskListTile(Task t) {
  return ListTile(
    title: Text(t.name),
    trailing: t.finish == Task.kFinish
        ? IconButton(
            onPressed: () => toggleTask(t),
            icon: const Icon(Icons.check_circle, color: Colors.green))
        : IconButton(
            onPressed: () => toggleTask(t),
            icon: const Icon(
              Icons.check_circle_outline,
            )),
  );
}
