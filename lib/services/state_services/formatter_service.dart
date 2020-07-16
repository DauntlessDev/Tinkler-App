import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@lazySingleton
class FormatterService extends ChangeNotifier {
  String formatDate(String firstTime) {
    DateTime firstDate = DateTime.parse(firstTime);

    if (firstDate.difference(DateTime.now()) > Duration(days: 365)) {
      return '${DateFormat.yMMMMd().format(firstDate)} AT ${DateFormat.jm().format(firstDate)}';
    } else if (firstDate.difference(DateTime.now()) > Duration(days: 7)) {
      return '${DateFormat.MMMMd().format(firstDate)} AT ${DateFormat.jm().format(firstDate)}';
    } else if (firstDate.day != DateTime.now().day) {
      return '${DateFormat.E().format(firstDate).toUpperCase()} AT ${DateFormat.jm().format(firstDate)}';
    } else {
      return DateFormat.jm().format(firstDate);
    }
  }
}
