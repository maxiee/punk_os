import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:punk_os/base/event_bus/event_bus.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/task/task/task_dashboard.dart';
import 'package:punk_os/kit/task/task/task_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    GetIt.I.get<EventBus>().register(kEventRefresh, refresh);
  }

  @override
  void dispose() {
    super.dispose();
    GetIt.I.get<EventBus>().dispose(refresh);
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            dashboardRecentTask(context, 5),
            MaterialButton(
              onPressed: () async {
                String? txt =
                    await prompt(context, title: const Text('输入任务名称'));
                if (txt == null) return;
                createTaskWithName(txt);
              },
              child: const Text("新任务"),
            ),
            MaterialButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed("/editor");
                },
                child: const Text('编辑器测试页'))
          ],
        ),
      ),
    );
  }
}
