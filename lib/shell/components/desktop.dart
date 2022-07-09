import 'package:flutter/material.dart';
import 'package:punk_os/shell/components/desktop/wallpaper.dart';
import 'package:utopia_wm/wm.dart';

class Desktop extends StatefulWidget {
  static final WindowHierarchyController wmController =
      WindowHierarchyController();

  const Desktop({Key? key}) : super(key: key);

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          const WallpaperLayer(),
          Positioned.fill(
              child: WindowHierarchy(
                  controller: Desktop.wmController,
                  layoutDelegate: const FreeformLayoutDelegate()))
        ],
      ),
    );
  }
}
