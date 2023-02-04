import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:ray_db/ray_db.dart';

class DBService {
  late Database database;

  DBService() {
    Future(() async {
      Directory dir = await getApplicationDocumentsDirectory();
      if (!await dir.exists()) await dir.create(recursive: true);
      database = await openDatabase(File(path.join(dir.path, "punk_os.dab")));
    });
  }
}
