import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tinkler/model/profile.dart';

class Post {
  String postId;
  String description;
  String pictureUrl;
  String time;
  Profile posterProfile;
  List<String> usersLike;
  List<String> comments;

  Post({
    @required this.postId,
    @required this.description,
    @required this.time,
    @required this.posterProfile,
    this.pictureUrl,
    this.usersLike,
    this.comments,
  });

  Post copyWith({
    String postId,
    String description,
    String pictureUrl,
    String time,
    Profile posterProfile,
    List<String> usersLike,
    List<String> comments,
  }) {
    return Post(
      postId: postId ?? this.postId,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      time: time ?? this.time,
      posterProfile: posterProfile ?? this.posterProfile,
      usersLike: usersLike ?? this.usersLike,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'description': description,
      'pictureUrl': pictureUrl,
      'time': time,
      'posterProfile': posterProfile?.toMap(),
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
      time: map['time'],
      posterProfile: Profile.fromMap(map['posterProfile']),
      usersLike: List<String>.from(map['usersLike']),
      comments: List<String>.from(map['comments']),
    );
  }

  String toJson() => json.encode(toMap());

  static Post fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postId: $postId, description: $description, pictureUrl: $pictureUrl, time: $time, posterProfile: $posterProfile, usersLike: $usersLike, comments: $comments)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post &&
        o.postId == postId &&
        o.description == description &&
        o.pictureUrl == pictureUrl &&
        o.time == time &&
        o.posterProfile == posterProfile &&
        listEquals(o.usersLike, usersLike) &&
        listEquals(o.comments, comments);
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        description.hashCode ^
        pictureUrl.hashCode ^
        time.hashCode ^
        posterProfile.hashCode ^
        usersLike.hashCode ^
        comments.hashCode;
  }
}
