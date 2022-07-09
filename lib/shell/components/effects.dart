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
import 'package:provider/provider.dart';
import 'package:punk_os/shell/components/layout.dart';
import 'package:punk_os/widgets/box_container.dart';
import 'package:utopia_wm/wm.dart';

import 'desktop.dart';

class EffectsLayer extends StatefulWidget {
  final EffectsLayerController controller;

  const EffectsLayer({required this.controller, super.key});

  @override
  State<EffectsLayer> createState() => EffectsLayerState();

  static EffectsLayerController? of(BuildContext context) {
    return Provider.of<EffectsLayerController?>(context, listen: false);
  }
}

class EffectsLayerState extends State<EffectsLayer>
    with TickerProviderStateMixin {
  static const double _dockRectInset = 8;
  static const int _dockEffectDuration = 200;

  late final AnimationController _rectController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: _dockEffectDuration),
  );
  late final AnimationController _opacityController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: _dockEffectDuration),
    value: 1,
  );
  Animation<double> get _curvedAnim => CurvedAnimation(
        parent: _rectController,
        curve: decelerateEasing,
      );
  final RectTween _rectTween = RectTween();
  LayoutState? _dockingWindow;
  Rect? _windowRect;
  WindowDock? _lastDock;

  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
    Desktop.wmController.addListener(_updateState);
  }

  @override
  void dispose() {
    Desktop.wmController.removeListener(_updateState);
    //widget.controller.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  Future<void> _updateWindowRect() async {
    _windowRect = _dockingWindow?.rect;

    if (_lastDock == WindowDock.none) {
      _rectTween.end = _windowRect?.deflate(16);
    } else if (_lastDock != null) {
      _rectTween.begin ??= _windowRect;
    }
  }

  void startDockEffect(LayoutState window) {
    _rectTween.begin = null;
    _rectTween.end = null;
    _rectController.value = 0;

    _lastDock = null;
    _dockingWindow = window;
    _dockingWindow!.addListener(_updateWindowRect);
  }

  void endDockEffect() {
    _rectTween.begin = null;
    _rectTween.end = null;
    _rectController.value = 0;

    _dockingWindow!.removeListener(_updateWindowRect);
    _dockingWindow = null;
    _windowRect = null;
    _lastDock = null;
  }

  Future<void> updateDockEffect(WindowDock dock) async {
    _lastDock = dock;
    if (dock == WindowDock.none) {
      _rectTween.begin = _rectTween.evaluate(_curvedAnim);
      _rectController.value = 0;
      _rectTween.end = _windowRect;

      _opacityController.animateTo(0);
      await _rectController.animateTo(1);

      _rectTween.begin = null;
      _rectTween.end = null;

      return;
    }

    if (_rectTween.begin == null) {
      _rectTween.begin = _windowRect;
    } else {
      _rectTween.begin = _rectTween.evaluate(_curvedAnim);
    }

    _rectController.value = 0;
    _rectTween.end = _insetRectForDock(
      PangolinLayoutDelegate.getRectForDock(dock, Desktop.wmController),
      dock,
    );

    _opacityController.value = 1;
    _rectController.animateTo(1);
  }

  Rect _insetRectForDock(Rect rect, WindowDock dock) {
    return const EdgeInsets.all(_dockRectInset).deflateRect(rect);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: Listenable.merge([_rectController, _opacityController]),
        builder: (context, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fromRect(
                rect: _rectTween.evaluate(_curvedAnim) ?? Rect.zero,
                child: FadeTransition(
                  opacity: _opacityController,
                  child: BoxSurface(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    dropShadow: true,
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class EffectsLayerController {
  EffectsLayerState? _state;

  void startDockEffect(LayoutState window) => _state?.startDockEffect(window);
  void endDockEffect() => _state?.endDockEffect();
  Future<void> updateDockEffect(WindowDock dock) async =>
      _state?.updateDockEffect(dock);
}
