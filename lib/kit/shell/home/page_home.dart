import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:punk_os/base/event_bus/event_bus.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/task/task/task_dashboard.dart';
import 'package:punk_os/kit/task/task/task_service.dart';
import 'package:punk_os/kit/wiki/wiki_dashboard.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: dashboardRecentTask(context, 5)),
              Expanded(child: dashboardRecentWiki(context, 5)),
            ]),
            Wrap(
              children: [
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
                    String? wikiName =
                        await prompt(context, title: const Text('输入Wiki名称'));
                    if (wikiName == null) return;
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed("/wiki", arguments: {
                      'wiki': getWikiByName(wikiName) ??
                          saveWiki(Wiki(name: wikiName, blockList: ""))
                    });
                  },
                  child: const Text("新 Wiki"),
                ),
                MaterialButton(
                    onPressed: () async {
                      String wikiName = "编辑器测试页";
                      Navigator.of(context).pushNamed("/wiki", arguments: {
                        'wiki': getWikiByName(wikiName) ??
                            saveWiki(Wiki(name: wikiName, blockList: ""))
                      });
                    },
                    child: const Text('编辑器测试页')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
