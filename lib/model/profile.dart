import 'dart:convert';

import 'package:flutter/foundation.dart';

class Profile {
  final String email;
  final String displayName;
  final List<String> caseSearch;
  final String photoUrl;

  Profile({
    @required this.email,
    @required this.displayName,
    @required this.photoUrl,
    this.caseSearch,
  });

  Profile copyWith({
    String email,
    String displayName,
    List<String> caseSearch,
    String photoUrl,
  }) {
    return Profile(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      caseSearch: caseSearch ?? this.caseSearch,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'caseSearch': caseSearch,
      'photoUrl': photoUrl,
    };
  }

  static Profile fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Profile(
      email: map['email'],
      displayName: map['displayName'],
      caseSearch: List<String>.from(map['caseSearch']),
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static Profile fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(email: $email, displayName: $displayName, caseSearch: $caseSearch, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Profile &&
        o.email == email &&
        o.displayName == displayName &&
        listEquals(o.caseSearch, caseSearch) &&
        o.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        displayName.hashCode ^
        caseSearch.hashCode ^
        photoUrl.hashCode;
  }
}
