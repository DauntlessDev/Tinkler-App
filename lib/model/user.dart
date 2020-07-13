import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.uid,
    @required this.email,
  });

  final String uid;
  final String email;

  User copyWith({
    String uid,
    String email,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      uid: map['uid'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'User(uid: $uid, email: $email)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.uid == uid &&
      o.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;
}
