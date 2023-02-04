import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:punk_os/kit/task/task/task_dashboard.dart';
import 'package:punk_os/kit/task/task/task_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            dashboardRecentTask(5),
            MaterialButton(
              onPressed: () async {
                String? txt =
                    await prompt(context, title: const Text('输入任务名称'));
                if (txt == null) return;
                final t = createTaskWithName(txt);
                debugPrint(t.toMap().toString());
              },
              child: const Text("新任务"),
            ),
            MaterialButton(
                onPressed: () => setState(() {}), child: const Text('刷新'))
          ],
        ),
      ),
    );
  }
}
