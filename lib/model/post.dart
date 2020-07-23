import 'dart:convert';

import 'package:tinkler/model/profile.dart';

class Post {
  String postId;
  String description;
  String pictureUrl;
  String time;
  int likesCount;
  int commentsCount;
  Profile posterProfile;
  Post({
    this.postId,
    this.description,
    this.pictureUrl,
    this.time,
    this.likesCount,
    this.commentsCount,
    this.posterProfile,
  });

  Post copyWith({
    String postId,
    String description,
    String pictureUrl,
    String time,
    int likesCount,
    int commentsCount,
    Profile posterProfile,
  }) {
    return Post(
      postId: postId ?? this.postId,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      time: time ?? this.time,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      posterProfile: posterProfile ?? this.posterProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'description': description,
      'pictureUrl': pictureUrl,
      'time': time,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'posterProfile': posterProfile?.toMap(),
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      postId: map['postId'],
      description: map['description'],
      pictureUrl: map['pictureUrl'],
      time: map['time'],
      likesCount: map['likesCount'],
      commentsCount: map['commentsCount'],
      posterProfile: Profile.fromMap(map['posterProfile']),
    );
  }

  String toJson() => json.encode(toMap());

  static Post fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postId: $postId, description: $description, pictureUrl: $pictureUrl, time: $time, likesCount: $likesCount, commentsCount: $commentsCount, posterProfile: $posterProfile)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post &&
        o.postId == postId &&
        o.description == description &&
        o.pictureUrl == pictureUrl &&
        o.time == time &&
        o.likesCount == likesCount &&
        o.commentsCount == commentsCount &&
        o.posterProfile == posterProfile;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        description.hashCode ^
        pictureUrl.hashCode ^
        time.hashCode ^
        likesCount.hashCode ^
        commentsCount.hashCode ^
        posterProfile.hashCode;
  }
}
