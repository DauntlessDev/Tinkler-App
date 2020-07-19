import 'dart:convert';

import 'package:flutter/foundation.dart';

class Chatroom {
  final List<String> users;
  final String chatroomID;
  final String chatName;

  Chatroom({
    this.users,
    this.chatroomID,
    this.chatName = '',
  });


  Chatroom copyWith({
    List<String> users,
    String chatroomID,
    String chatName,
  }) {
    return Chatroom(
      users: users ?? this.users,
      chatroomID: chatroomID ?? this.chatroomID,
      chatName: chatName ?? this.chatName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'users': users,
      'chatroomID': chatroomID,
      'chatName': chatName,
    };
  }

  static Chatroom fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Chatroom(
      users: List<String>.from(map['users']),
      chatroomID: map['chatroomID'],
      chatName: map['chatName'],
    );
  }

  String toJson() => json.encode(toMap());

  static Chatroom fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Chatroom(users: $users, chatroomID: $chatroomID, chatName: $chatName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Chatroom &&
      listEquals(o.users, users) &&
      o.chatroomID == chatroomID &&
      o.chatName == chatName;
  }

  @override
  int get hashCode => users.hashCode ^ chatroomID.hashCode ^ chatName.hashCode;
}
