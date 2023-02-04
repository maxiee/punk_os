import 'package:get_it/get_it.dart';
import 'package:punk_os/base/event_bus/event_bus.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/task/task/task_model.dart';
import 'package:ray_db/ray_db.dart';

const String kCollectionNameTask = 'task';

Task createTaskWithName(String name) {
  return saveTask(
      Task(name: name, finish: Task.kUnfinish, created: DateTime.now()));
}

Task saveTask(Task t) {
  GetIt.I.get<Database>().collection(kCollectionNameTask).storeMap(t.toMap());
  GetIt.I.get<EventBus>().dispatch(kEventRefresh);
  return t;
}

Task toggleTask(Task t) {
  t.finish = t.finish == Task.kFinish ? Task.kUnfinish : Task.kFinish;
  GetIt.I.get<Database>().collection(kCollectionNameTask).storeMap(t.toMap());
  GetIt.I.get<EventBus>().dispatch(kEventRefresh);
  return t;
}

List<Task> getRecentTasks(int limit) {
  return GetIt.I
      .get<Database>()
      .collection(kCollectionNameTask)
      .where()
      .limit(limit)
      .findAll()
      .map((e) => Task.fromMap(e))
      .toList();
}
