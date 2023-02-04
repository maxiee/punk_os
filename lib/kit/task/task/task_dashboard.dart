import 'package:flutter/material.dart';
import 'package:punk_os/kit/shell/dashboard/widget/dashboard_list.dart';
import 'package:punk_os/kit/task/task/task_service.dart';

DashboardList dashboardRecentTask(int limit) {
  return DashboardList(
      title: "最近任务",
      items: getRecentTasks(limit)
          .map((e) => ListTile(
                title: Text(e.toString()),
              ))
          .toList());
}
