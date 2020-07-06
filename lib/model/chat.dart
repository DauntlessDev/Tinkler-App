import 'package:flutter/material.dart';

class Chat {
  final String name;
  final String photoUrl;
  final String latestMessage;
  final String time;

  const Chat({
    @required this.name,
    @required this.photoUrl,
    @required this.latestMessage,
    @required this.time,
  });
}
