import 'package:cloud_firestore/cloud_firestore.dart';

class APIPath {
  static String users() => 'users/';
  static String userInfo(String uid) => 'users/$uid';

  static String profilePic(String uid) => 'profilePics/$uid';

  static String chatroom(String chatroomId) => 'chatrooms/$chatroomId';

  static String chatroomMessages(String chatroomId) =>
      'chatrooms/$chatroomId/messages/';
  static String chatroomMessage({String chatroomId, String messageId}) =>
      'chatrooms/$chatroomId/messages/$messageId';
}
