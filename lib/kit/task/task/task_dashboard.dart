import 'package:punk_os/kit/shell/dashboard/widget/dashboard_list.dart';
import 'package:punk_os/kit/task/task/task_item.dart';
import 'package:punk_os/kit/task/task/task_model.dart';
import 'package:punk_os/kit/task/task/task_service.dart';

DashboardList dashboardRecentTask(int limit) {
  return DashboardList(
      title: "待办任务",
      items: getRecentTasks(limit)
          .where((e) => e.finish == Task.kUnfinish)
          .map((e) => taskListTile(e))
          .toList());
}
