import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tinkler/model/profile.dart';

import 'message.dart';

class Chat {
  Profile profile;
  Message lastMessage;

  Chat({
    @required this.profile,
    @required this.lastMessage,
  });

  Chat copyWith({
    Profile profile,
    Message lastMessage,
  }) {
    return Chat(
      profile: profile ?? this.profile,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profile': profile?.toMap(),
      'lastMessage': lastMessage?.toMap(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Chat(
      profile: Profile.fromMap(map['profile']),
      lastMessage: Message.fromMap(map['lastMessage']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() => 'Chat(profile: $profile, lastMessage: $lastMessage)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Chat && o.profile == profile && o.lastMessage == lastMessage;
  }

  @override
  int get hashCode => profile.hashCode ^ lastMessage.hashCode;
}
