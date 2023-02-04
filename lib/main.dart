import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/shell/home/page_home.dart';
import 'package:ray_db/ray_db.dart' as db;
import 'package:path/path.dart' as path;

void main() async {
  // init database
  Directory dir = Directory(kHomePath);
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
