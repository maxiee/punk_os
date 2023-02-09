import 'package:flutter/material.dart';
import 'package:punk_os/kit/shell/dashboard/widget/dashboard_list.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';

DashboardList dashboardMarkWiki(BuildContext context) {
  return DashboardList(
      title: "收藏 Wiki",
      items: getMarkWiki()
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
