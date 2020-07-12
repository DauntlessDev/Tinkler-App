import 'dart:convert';

import 'package:flutter/foundation.dart';

class Profile {
  Profile({
    @required this.email,
    @required this.displayName,
    @required this.photoUrl,
  });

  final String email;
  final String displayName;
  final String photoUrl;


  Profile copyWith({
    String email,
    String displayName,
    String photoUrl,
  }) {
    return Profile(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  static Profile fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Profile(
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static Profile fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Profile(email: $email, displayName: $displayName, photoUrl: $photoUrl)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Profile &&
      o.email == email &&
      o.displayName == displayName &&
      o.photoUrl == photoUrl;
  }

  @override
  int get hashCode => email.hashCode ^ displayName.hashCode ^ photoUrl.hashCode;
}
