import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punk_os/services/datetime/time_service.dart';
import 'package:punk_os/shell/components/desktop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TimeService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Desktop(),
      ),
    );
  }
}
