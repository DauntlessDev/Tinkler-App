import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.uid,
    this.displayName,
    this.photoUrl,
  });

  final String uid;
  final String displayName;
  final String photoUrl;

  User copyWith({
    String uid,
    String displayName,
    String photoUrl,
  }) {
    return User(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      uid: map['uid'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'User(uid: $uid, displayName: $displayName, photoUrl: $photoUrl)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.uid == uid &&
        o.displayName == displayName &&
        o.photoUrl == photoUrl;
  }

  @override
  int get hashCode => uid.hashCode ^ displayName.hashCode ^ photoUrl.hashCode;
}
