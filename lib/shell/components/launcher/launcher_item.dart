import 'package:flutter/material.dart';
import 'package:punk_os/shell/utils/data/model/application.dart';

class LauncherItem extends StatelessWidget {
  Application application;

  LauncherItem(this.application, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        application.launch(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icons/${application.iconName}.png"),
          const SizedBox(height: 8),
          DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Text(application.name ?? 'unknown'),
          ),
        ],
      ),
    );
  }
}
