import 'dart:async';

import 'package:flutter/material.dart';
import 'package:punk_os/shell/components/shell.dart';
import 'package:punk_os/shell/utils/data/app_list.dart';
import 'package:punk_os/shell/utils/data/common_data.dart';
import 'package:punk_os/shell/wm/wm_api.dart';

class LauncherOverlay extends ShellOverlay {
  static const String overlayId = 'launcher';

  LauncherOverlay({Key? key}) : super(key: key, id: overlayId);

  @override
  _LauncherOverlayState createState() => _LauncherOverlayState();
}

class _LauncherOverlayState extends State<LauncherOverlay>
    with ShellOverlayState, SingleTickerProviderStateMixin {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) {
    ac.reverse();
    WmAPI.of(context).undoMinimizeAll();
    controller.showing = false;
  }

  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) {
    ac.forward();
    controller.showing = true;
    WmAPI.of(context).minimizeAll();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> _animation = CurvedAnimation(
      parent: ac,
      curve: CommonData.of(context).animationCurve(),
    );
    final apps = applications;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child)  => FadeTransition(opacity: _animation,
      child: Container(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, childAspectRatio: 1.0),
          children: apps.map((e) => Text(e.name ?? 'unknown')).toList(),
        ),
      )),
    );
  }
}
