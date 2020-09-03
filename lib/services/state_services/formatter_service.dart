import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@lazySingleton
class FormatterService extends ChangeNotifier {
  String formatDate(String firstTime) {
    DateTime firstDate = DateTime.parse(firstTime);
    print('difference : ${firstDate.difference(DateTime.now()).inDays}');

    if (firstDate.difference(DateTime.now()).abs() > Duration(days: 365)) {
      return '${DateFormat.yMMMMd().format(firstDate)} AT ${DateFormat.jm().format(firstDate)}';
    } else if (firstDate.difference(DateTime.now()).abs() >=
        Duration(days: 6)) {
      return '${DateFormat.MMMMd().format(firstDate)} AT ${DateFormat.jm().format(firstDate)}';
    } else if (firstDate.day != DateTime.now().day &&
        firstDate.difference(DateTime.now()) < Duration(days: 6)) {
      return '${DateFormat.E().format(firstDate).toUpperCase()} AT ${DateFormat.jm().format(firstDate)}';
    } else {
      return DateFormat.jm().format(firstDate);
    }
  }

  String formatPostDate(String firstTime) {
    DateTime firstDate = DateTime.parse(firstTime);

    if (firstDate.difference(DateTime.now()).abs() > Duration(days: 365)) {
      return '${DateFormat.yMMMMd().format(firstDate)}';
    } else if (firstDate.day != DateTime.now().day) {
      return '${DateFormat.MMMMd().format(firstDate)}';
    } else if (firstDate.difference(DateTime.now()).abs() >=
        Duration(hours: 1)) {
      return '${firstDate.difference(DateTime.now()).inHours}h';
    } else if (firstDate.difference(DateTime.now()).abs() >=
        Duration(minutes: 1)) {
      return '${firstDate.difference(DateTime.now()).inMinutes}m';
    } else if (firstDate.difference(DateTime.now()).abs() >=
        Duration(seconds: 10)) {
      return '${firstDate.difference(DateTime.now()).inSeconds}s';
    } else if (firstDate.difference(DateTime.now()).abs() <
        Duration(seconds: 10)) {
      return 'now';
    } else {
      return '${firstDate.difference(DateTime.now()).inHours}h';
    }
  }
}
