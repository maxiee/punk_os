import 'dart:io';

import 'package:ray_db/ray_db.dart';

class RayInfoDB {
  RayInfoDB() {
    Future(() async {
      db = await openDatabase(File("D:\\SynologyDrive\\ray_info\\ray_info.db"));
    });
  }

  late Database db;
}