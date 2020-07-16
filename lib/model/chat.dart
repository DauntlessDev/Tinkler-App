import 'package:flutter/foundation.dart';

class Chat {
  final String name;
  final String photoUrl;
  final String lastMessage;
  final String time;

  const Chat({
    @required this.name,
    @required this.photoUrl,
    @required this.lastMessage,
    @required this.time,
  });
}
