import 'dart:convert';

import 'package:flutter/foundation.dart';

class Profile {
  Profile({
    @required this.email,
    @required this.isDarkMode,
    @required this.displayName,
    this.photoUrl,
  });

  final String email;
  final bool isDarkMode;
  final String displayName;
  final String photoUrl;

  Profile copyWith({
    String email,
    bool isDarkMode,
    String displayName,
    String photoUrl,
  }) {
    return Profile(
      email: email ?? this.email,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'isDarkMode': isDarkMode,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  static Profile fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Profile(
      email: map['email'],
      isDarkMode: map['isDarkMode'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static Profile fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(email: $email, isDarkMode: $isDarkMode, displayName: $displayName, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Profile &&
      o.email == email &&
      o.isDarkMode == isDarkMode &&
      o.displayName == displayName &&
      o.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      isDarkMode.hashCode ^
      displayName.hashCode ^
      photoUrl.hashCode;
  }
}
