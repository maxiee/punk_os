import 'package:flutter/material.dart';

class WallpaperLayer extends StatelessWidget {
  const WallpaperLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.blue.shade100,
      ),
    );
  }
}
