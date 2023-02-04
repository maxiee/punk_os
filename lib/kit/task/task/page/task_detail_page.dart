import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:punk_os/kit/task/task/task_model.dart';
import 'package:punk_os/kit/task/task/task_service.dart';

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

  final _formKey = GlobalKey<FormBuilderState>();
  late Task task;

  onSubmit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final value = _formKey.currentState!.value;
      _formKey.currentState!.reset();
      task.name = value['name'];
      task.finish = value['finish'] == true ? Task.kFinish : Task.kUnfinish;
      task.created = value['created'];
      task.deadline = value['deadline'];
      saveTask(task);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    task = arguments['task'];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FormBuilderTextField(
              name: 'name',
              decoration: const InputDecoration(labelText: '任务名称'),
              validator: FormBuilderValidators.required(),
              initialValue: task.name,
            ),
            FormBuilderCheckbox(
              name: 'finish',
              title: const Text('完成'),
              initialValue: task.finish == Task.kFinish,
            ),
            const Text("截至时间"),
            FormBuilderDateTimePicker(
                name: 'deadline', initialDate: task.deadline),
            const Text("创建时间"),
            FormBuilderDateTimePicker(
                name: 'created', initialValue: task.created),
            const SizedBox(height: 20),
            MaterialButton(onPressed: onSubmit, child: const Text('保存'))
          ]),
        ),
      ),
    );
  }
}
