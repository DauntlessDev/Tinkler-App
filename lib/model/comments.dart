import 'dart:convert';

import 'package:flutter/foundation.dart';

class Comment {
  final String commendId;
  final String senderEmail;
  final String commentTime;
  final String commentContent;

  Comment({
    @required this.commendId,
    @required this.senderEmail,
    @required this.commentTime,
    @required this.commentContent,
  });

  Comment copyWith({
    String commendId,
    String senderEmail,
    String commentTime,
    String commentContent,
  }) {
    return Comment(
      commendId: commendId ?? this.commendId,
      senderEmail: senderEmail ?? this.senderEmail,
      commentTime: commentTime ?? this.commentTime,
      commentContent: commentContent ?? this.commentContent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commendId': commendId,
      'senderEmail': senderEmail,
      'commentTime': commentTime,
      'commentContent': commentContent,
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      commendId: map['commendId'],
      senderEmail: map['senderEmail'],
      commentTime: map['commentTime'],
      commentContent: map['commentContent'],
    );
  }

  String toJson() => json.encode(toMap());

  static Comment fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(commendId: $commendId, senderEmail: $senderEmail, commentTime: $commentTime, commentContent: $commentContent)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Comment &&
        o.commendId == commendId &&
        o.senderEmail == senderEmail &&
        o.commentTime == commentTime &&
        o.commentContent == commentContent;
  }

  @override
  int get hashCode {
    return commendId.hashCode ^
        senderEmail.hashCode ^
        commentTime.hashCode ^
        commentContent.hashCode;
  }
}
