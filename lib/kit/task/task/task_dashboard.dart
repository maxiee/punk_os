import 'package:flutter/material.dart';
import 'package:punk_os/kit/shell/dashboard/widget/dashboard_list.dart';
import 'package:punk_os/kit/task/task/widget/task_item.dart';
import 'package:punk_os/kit/task/task/task_model.dart';
import 'package:punk_os/kit/task/task/task_service.dart';

DashboardList dashboardRecentTask(BuildContext context, int limit) {
  return DashboardList(
      title: "待办任务",
      items: getRecentTasks(1000)
          .where((e) => e.finish == Task.kUnfinish)
          .map((e) => taskListTile(context, e))
          .toList());
}
