/*
Copyright 2021 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:punk_os/shell/utils/data/app_list.dart';
import 'package:punk_os/shell/wm/properties.dart';
import 'package:punk_os/shell/wm/window/surface.dart';
import 'package:punk_os/shell/wm/window/toolbar.dart';
import 'package:utopia_wm/wm.dart';

class WmAPI {
  late BuildContext context;
  WmAPI.of(this.context);

  late final WindowHierarchyController _windowHierarchy =
      WindowHierarchy.of(context, listen: false);

  // late final MiscProvider _miscProvider =
  //     MiscProvider.of(context, listen: false);

  static WindowEntry windowEntry = const WindowEntry(
    features: [
      ResizeWindowFeature(),
      SurfaceWindowFeature(),
      FocusableWindowFeature(),
      ToolbarWindowFeature(),
    ],
    layoutInfo: FreeformLayoutInfo(
      position: Offset(32, 32),
      size: Size(1280, 720),
    ),
    properties: {
      ResizeWindowFeature.minSize: Size(480, 360),
      SurfaceWindowFeature.elevation: 4.0,
      SurfaceWindowFeature.shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      SurfaceWindowFeature.background: PangolinWindowSurface(),
      ToolbarWindowFeature.widget: PangolinWindowToolbar(
        barColor: Colors.transparent,
        textColor: Colors.black,
      ),
      ToolbarWindowFeature.size: 40.0,
    },
  );

  void popWindowEntry(String id) {
    _windowHierarchy.removeWindowEntry(id);
  }

  void pushWindowEntry(LiveWindowEntry entry) {
    _windowHierarchy.addWindowEntry(entry);
  }

  void openApp(String packageName) {
    final application = getApp(packageName);
    if (!application.canBeOpened) {
      return;
      // throw 'The app couldn not be opened';
    }
    final LiveWindowEntry _window = windowEntry.newInstance(
      content: application.app,
      overrideProperties: {
        WindowEntry.title: application.name,
        WindowEntry.icon: getAppIconProvider(
          application.systemExecutable,
          application.iconName,
        ),
        WindowExtras.stableId: packageName,
      },
      overrideLayout: (info) => info.copyWith(
        size: MediaQuery.of(context).size.width < 1920
            ? const Size(720, 480)
            : MediaQuery.of(context).size.width < 1921
                ? const Size(1280, 720)
                : const Size(1920, 1080),
      ),
    );

    pushWindowEntry(_window);
  }

  void minimizeAll() {
    // _miscProvider.minimizedWindowsCache = [];
    // for (final LiveWindowEntry e in _windowHierarchy.entries) {
    //   if (e.layoutState.minimized) {
    //     _miscProvider.minimizedWindowsCache.add(e.registry.info.id);
    //   } else {
    //     e.layoutState.minimized = true;
    //   }
    // }
  }

  void undoMinimizeAll() {
    // for (final LiveWindowEntry e in _windowHierarchy.entries) {
    //   _miscProvider.minimizedWindowsCache.contains(e.registry.info.id)
    //       ? e.layoutState.minimized = true
    //       : e.layoutState.minimized = false;
    // }
  }
}
