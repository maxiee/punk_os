import 'package:flutter/material.dart';
import 'package:punk_os/kit/task/task/task_model.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  late Task task;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    task = arguments['task'];

    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(),
    );
  }
}
