import 'dart:async';

import 'package:flutter/material.dart';
import 'package:punk_os/kit/info/info_service.dart';

class DBBusyPage extends StatefulWidget {
  const DBBusyPage({super.key});

  @override
  State<DBBusyPage> createState() => _DBBusyPageState();
}

class _DBBusyPageState extends State<DBBusyPage> {
  late Timer poller;
  bool busy = true;
  
  @override
  void initState() {
    super.initState();
    poller = Timer.periodic(const Duration(milliseconds: 1000), (timer) async {
      final ret = await isDBBusy();
      setState(() {
        busy = ret;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    poller.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RayInfo 繁忙状态')),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("状态"),
          Text(busy ? "繁忙" : "空闲"),
          const SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),
          )
        ],
      )),
    );
  }
}
