import 'dart:io';

import 'package:calculator/calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:punk_os/shell/utils/data/model/application.dart';

List<Application> get applications => <Application>[
      Application(
        color: Colors.green,
        packageName: "io.dahlia.calculator",
        app: Calculator(),
        name: 'Calculator',
        description: 'Calculator',
        iconName: "calculator",
        category: ApplicationCategory.office,
      ),
    ];

Application getApp(String packageName) {
  return applications
      .firstWhere((element) => element.packageName == packageName);
}

ImageProvider getAppIconProvider(bool usesRuntime, String? iconPath) {
  if (iconPath == null) {
    return const AssetImage('assets/icons/null.png');
  }
  if (usesRuntime == true) {
    return FileImage(File(iconPath));
  } else {
    return AssetImage("assets/icons/$iconPath.png");
  }
}

extension AppWebExtension on Application {
  bool get canBeOpened {
    if (kIsWeb) return supportsWeb;
    return true;
  }
}
