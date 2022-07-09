import 'package:flutter/material.dart';
import 'package:punk_os/shell/components/desktop/wallpaper.dart';
import 'package:punk_os/shell/components/layout.dart';
import 'package:punk_os/shell/components/shell.dart';
import 'package:punk_os/shell/wm/properties.dart';
import 'package:utopia_wm/wm.dart';

class Desktop extends StatefulWidget {
  static final WindowHierarchyController wmController =
      WindowHierarchyController();

  const Desktop({Key? key}) : super(key: key);

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  static const shellEntry = WindowEntry(
      features: [],
      layoutInfo: FreeformLayoutInfo(
          alwaysOnTop: true, alwaysOnTopMode: AlwaysOnTopMode.systemOverlay),
      properties: {
        WindowEntry.title: 'shell',
        WindowExtras.stableId: "shell",
        WindowEntry.showOnTaskbar: false,
        WindowEntry.icon: null,
      });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Desktop.wmController
          .addWindowEntry(shellEntry.newInstance(content: Shell(overlays: [])));
      Desktop.wmController.addWindowEntry(WindowEntry(
          layoutInfo: FreeformLayoutInfo(),
          features: [],
          properties: {
            WindowEntry.id: 'hello',
            WindowExtras.stableId: "hello",
            WindowEntry.title: 'Hello'
          }).newInstance(content: FlutterLogo(size: 60)));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Desktop.wmController.wmInsets = EdgeInsets.only(
      left: 0,
      top: 0,
      right: 0,
      bottom: 48,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(Desktop.wmController.rawEntries.toString());
    return SizedBox.expand(
      child: Stack(
        children: [
          const WallpaperLayer(),
          Positioned.fill(
              child: WindowHierarchy(
                  useParentSize: true,
                  controller: Desktop.wmController,
                  layoutDelegate: const PangolinLayoutDelegate())),
        ],
      ),
    );
  }
}
