import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:tinkler/model/profile.dart';

class Post {
  String postId;
  String description;
  String pictureUrl;
  Profile profile;
  List<String> usersLike;
  List<String> comments;
  Post({
    @required this.postId,
    @required this.description,
    this.pictureUrl,
    @required this.profile,
    this.usersLike,
    this.comments,
  });

  Post copyWith({
    String postId,
    String description,
    String pictureUrl,
    Profile profile,
    List<String> usersLike,
    List<String> comments,
  }) {
    return Post(
      postId: postId ?? this.postId,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      profile: profile ?? this.profile,
      usersLike: usersLike ?? this.usersLike,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'description': description,
      'pictureUrl': pictureUrl,
      'profile': profile?.toMap(),
      'usersLike': usersLike,
      'comments': comments,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      postId: map['postId'],
      description: map['description'],
      pictureUrl: map['pictureUrl'],
      profile: Profile.fromMap(map['profile']),
      usersLike: List<String>.from(map['usersLike']),
      comments: List<String>.from(map['comments']),
    );
  }

  String toJson() => json.encode(toMap());

  static Post fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postId: $postId, description: $description, pictureUrl: $pictureUrl, profile: $profile, usersLike: $usersLike, comments: $comments)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post &&
        o.postId == postId &&
        o.description == description &&
        o.pictureUrl == pictureUrl &&
        o.profile == profile &&
        listEquals(o.usersLike, usersLike) &&
        listEquals(o.comments, comments);
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        description.hashCode ^
        pictureUrl.hashCode ^
        profile.hashCode ^
        usersLike.hashCode ^
        comments.hashCode;
  }
}
