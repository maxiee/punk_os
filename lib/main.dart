import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:punk_os/kit/task/task/task_service.dart';
import 'package:ray_db/ray_db.dart' as db;
import 'package:path/path.dart' as path;

void main() async {
  // init database
  Directory dir = await getApplicationDocumentsDirectory();
  if (!await dir.exists()) await dir.create(recursive: true);
  debugPrint(dir.path);
  db.Database database =
      await db.openDatabase(File(path.join(dir.path, "punk_os.db")));

  GetIt.I.registerSingleton(database);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

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
            const Text(
              'You have pushed the button this many times:',
            ),
            MaterialButton(
              onPressed: () async {
                String? txt =
                    await prompt(context, title: const Text('输入任务名称'));
                if (txt == null) return;
                final t = createTaskWithName(txt);
                debugPrint(t.toMap().toString());
              },
              child: const Text("新任务"),
            )
          ],
        ),
      ),
    );
  }
}
