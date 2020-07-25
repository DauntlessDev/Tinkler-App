import 'dart:convert';

import 'package:flutter/foundation.dart';

class Profile {
  final String email;
  final String displayName;
  final String photoUrl;
  final int posts;
  final int followers;
  final int following;
  final List<String> caseSearch;

  Profile({
    @required this.email,
    @required this.displayName,
    @required this.photoUrl,
    @required this.posts,
    @required this.followers,
    @required this.following,
    this.caseSearch,
  });

  Profile copyWith({
    String email,
    String displayName,
    String photoUrl,
    int posts,
    int followers,
    int following,
    List<String> caseSearch,
  }) {
    return Profile(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      posts: posts ?? this.posts,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      caseSearch: caseSearch ?? this.caseSearch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'posts': posts,
      'followers': followers,
      'following': following,
      'caseSearch': caseSearch,
    };
  }

  static Profile fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Profile(
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      posts: map['posts'],
      followers: map['followers'],
      following: map['following'],
      caseSearch: List<String>.from(map['caseSearch']),
    );
  }

  String toJson() => json.encode(toMap());

  static Profile fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(email: $email, displayName: $displayName, photoUrl: $photoUrl, posts: $posts, followers: $followers, following: $following, caseSearch: $caseSearch)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Profile &&
        o.email == email &&
        o.displayName == displayName &&
        o.photoUrl == photoUrl &&
        o.posts == posts &&
        o.followers == followers &&
        o.following == following &&
        listEquals(o.caseSearch, caseSearch);
  }

  @override
  int get hashCode {
    return email.hashCode ^
        displayName.hashCode ^
        photoUrl.hashCode ^
        posts.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        caseSearch.hashCode;
  }
}
