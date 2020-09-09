import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tinkler/model/message.dart';

class Chatroom {
  final List<String> users;
  final String chatroomID;
  final String chatName;
  final Message lastMessage;
  Chatroom({
    this.users,
    this.chatroomID,
    this.chatName,
    this.lastMessage,
  });

  Chatroom copyWith({
    List<String> users,
    String chatroomID,
    String chatName,
    Message lastMessage,
  }) {
    return Chatroom(
      users: users ?? this.users,
      chatroomID: chatroomID ?? this.chatroomID,
      chatName: chatName ?? this.chatName,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'users': users,
      'chatroomID': chatroomID,
      'chatName': chatName,
      'lastMessage': lastMessage?.toMap(),
    };
  }

  factory Chatroom.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Chatroom(
      users: List<String>.from(map['users']),
      chatroomID: map['chatroomID'],
      chatName: map['chatName'],
      lastMessage: Message.fromMap(map['lastMessage']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chatroom.fromJson(String source) =>
      Chatroom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Chatroom(users: $users, chatroomID: $chatroomID, chatName: $chatName, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Chatroom &&
        listEquals(o.users, users) &&
        o.chatroomID == chatroomID &&
        o.chatName == chatName &&
        o.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return users.hashCode ^
        chatroomID.hashCode ^
        chatName.hashCode ^
        lastMessage.hashCode;
  }
}
