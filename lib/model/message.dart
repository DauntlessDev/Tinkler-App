import 'dart:convert';

import 'package:flutter/foundation.dart';

class Message {
  final String sender;
  final String time;
  final String message;

  Message({
    @required this.sender,
    @required this.time,
    @required this.message,
  });

  Message copyWith({
    String sender,
    String time,
    String message,
  }) {
    return Message(
      sender: sender ?? this.sender,
      time: time ?? this.time,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'time': time,
      'message': message,
    };
  }

  static Message fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      sender: map['sender'],
      time: map['time'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  static Message fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'Message(sender: $sender, time: $time, message: $message)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Message &&
        o.sender == sender &&
        o.time == time &&
        o.message == message;
  }

  @override
  int get hashCode => sender.hashCode ^ time.hashCode ^ message.hashCode;
}
