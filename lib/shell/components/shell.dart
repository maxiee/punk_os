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
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punk_os/shell/components/taskbar/taskbar.dart';
import 'package:punk_os/shell/components/taskbar/widgets/launch.dart';
import 'package:punk_os/shell/wm/wm_api.dart';

class Shell extends StatefulWidget {
  final List<ShellOverlay> overlays;

  const Shell({required this.overlays, Key? key}) : super(key: key);

  @override
  State<Shell> createState() => _ShellState();

  static _ShellState of(BuildContext context, {bool listen = true}) {
    return Provider.of<_ShellState>(context, listen: listen);
  }
}

class _ShellState extends State<Shell> {
  @override
  void initState() {
    Future(() {
      WmAPI.of(context).openApp("io.dahlia.calculator");
      WmAPI.of(context).openApp('com.maxiee.rayplan');
    });
  }

  Future<void> dismissOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
  }) async {
    final ShellOverlay overlay =
        widget.overlays.firstWhere((o) => o.id == overlayId);
    await overlay._controller.requestDismiss(args);
  }

  Future<void> showOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
    bool dismissEverything = true,
  }) async {
    final ShellOverlay overlay =
        widget.overlays.firstWhere((o) => o.id == overlayId);
    if (dismissEverything) this.dismissEverything();
    await overlay._controller.requestShow(args);
  }

  Future<void> toggleOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
  }) async {
    if (!currentlyShown(overlayId)) {
      await showOverlay(overlayId, args: args);
    } else {
      await dismissOverlay(overlayId, args: args);
    }
  }

  bool currentlyShown(String overlayId) {
    final ShellOverlay overlay =
        widget.overlays.firstWhere((o) => o.id == overlayId);
    return overlay._controller.showing;
  }

  List<String> get currentlyShownOverlays {
    final List<String> shownIds = [];
    for (final ShellOverlay o in widget.overlays) {
      if (o._controller.showing) shownIds.add(o.id);
    }
    return shownIds;
  }

  ValueNotifier<bool> getShowingNotifier(String overlayId) {
    final ShellOverlay overlay =
        widget.overlays.firstWhere((o) => o.id == overlayId);
    return overlay._controller.showingNotifier;
  }

  void dismissEverything() {
    for (final String id in currentlyShownOverlays) {
      dismissOverlay(id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                child: Listener(
              onPointerDown: (event) {
                dismissEverything();
              },
              behavior: HitTestBehavior.translucent,
            )),
            Taskbar(leading: [const LauncherButton()], trailing: [])
          ],
        ),
      ),
    );
  }
}

class ShellOverlayController<T extends ShellOverlayState> {
  T? _overlay;
  final ValueNotifier<bool> showingNotifier = ValueNotifier(false);

  bool get showing => showingNotifier.value;
  set showing(bool value) => showingNotifier.value = value;

  Future<void> requestShow(Map<String, dynamic> args) async {
    _requireOverlayConnection();
    await _overlay!.requestShow(args);
  }

  Future<void> requestDismiss(Map<String, dynamic> args) async {
    _requireOverlayConnection();
    await _overlay!.requestDismiss(args);
  }

  void _requireOverlayConnection() {
    if (_overlay == null) {
      throw Exception(
        "The controller is not connected to any overlay or it had no time to connect yet.",
      );
    }
  }
}

abstract class ShellOverlay extends StatefulWidget {
  final String id;
  final ShellOverlayController _controller = ShellOverlayController();

  ShellOverlay({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ShellOverlayState createState();
}

mixin ShellOverlayState<T extends ShellOverlay> on State<T> {
  ShellOverlayController get controller => widget._controller;

  @override
  void initState() {
    controller._overlay = this;
    controller.showingNotifier.addListener(_showListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.showingNotifier.removeListener(_showListener);
    super.dispose();
  }

  FutureOr<void> requestShow(Map<String, dynamic> args);

  FutureOr<void> requestDismiss(Map<String, dynamic> args);

  void _showListener() {
    setState(() {});
  }
}
