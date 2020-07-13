import 'package:cloud_firestore/cloud_firestore.dart';

class APIPath {
  static String users() => 'users/';
  static String profile(String uid) => 'users/$uid';
  static String profilePic(String uid) => 'profilePics/$uid';

  static String chatroom(String chatroomId) => 'chatrooms/$chatroomId';
  static String chatroomMessage({String chatroomId, String messageId}) =>
      'chatrooms/$chatroomId/messages/$messageId';
  // static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  // static String jobs(String uid) => 'users/$uid/jobs';
  // static String entry(String uid, String entryId) =>
  //     'users/$uid/entries/$entryId';
  // static String entries(String uid) => 'users/$uid/entries';
}
