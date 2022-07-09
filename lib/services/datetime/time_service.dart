import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeService extends ChangeNotifier {
  static TimeService of(BuildContext context, {bool listen = true}) =>
      Provider.of<TimeService>(context, listen: listen);

  static const dateFormat = 'yyyy-MM-dd';
  static const datetimeHMFormat = 'yyyy-MM-dd hh:mm';
  static const datetimeFormat = 'yyyy-MM-dd hh:mm:ss';
  static const timeHMFormat = 'hh:mm';

  DateTime currentTime = DateTime.now();

  late Timer _timer;

  TimeService() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime = DateTime.now();
      notifyListeners();
    });
  }

  String toDateString() {
    return DateFormat(dateFormat).format(currentTime);
  }

  String toDatetimeHMSString() {
    return DateFormat(datetimeFormat).format(currentTime);
  }

  String toDatetimeHMString() {
    return DateFormat(datetimeHMFormat).format(currentTime);
  }

  String toTimeHMString() {
    return DateFormat(timeHMFormat).format(currentTime);
  }
}
