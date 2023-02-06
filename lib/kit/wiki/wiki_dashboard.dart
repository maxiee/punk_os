import 'package:flutter/material.dart';
import 'package:punk_os/kit/shell/dashboard/widget/dashboard_list.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';

DashboardList dashboardRecentWiki(BuildContext context, int limit) {
  return DashboardList(
      title: "最近 Wiki",
      items: getRecentWikiw(limit)
          .map((e) => ListTile(
                title: Text(e.name),
                onTap: () {
                  Navigator.of(context).pushNamed("/wiki", arguments: {
                    'wiki': getWikiByName(e.name) ??
                        saveWiki(
                            Wiki(name: e.name, content: "", contentStr: ""))
                  });
                },
              ))
          .toList());
}
