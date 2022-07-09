import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punk_os/services/datetime/time_service.dart';
import 'package:punk_os/shell/components/taskbar/taskbar_element.dart';

class TaskTime extends StatelessWidget {
  const TaskTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaskbarElement(
      size: const Size(100, 48),
      child: Center(
        child: Consumer<TimeService>(builder: (context, service, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                service.toTimeHMString(),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                service.toDateString(),
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600),
              ),
            ],
          );
        }),
      ),
    );
  }
}
