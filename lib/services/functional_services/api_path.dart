class APIPath {
  static String users() => 'users/';
  static String userInfo(String uid) => 'users/$uid';

  static String profilePic(String uid) => 'profilePics/$uid';

  static String followerSpecific(String uid, String email) =>
      'followers/$uid/followers/$email';
  static String followingSpecific(String uid, String email) =>
      'following/$uid/following/$email';

  static String following(String uid) => 'following/$uid/following';

  static String chatroom(String chatroomId) => 'chatrooms/$chatroomId';
  static String chatrooms() => 'chatrooms/';

  static String chatroomMessages(String chatroomId) =>
      '/chatrooms/$chatroomId/messages';
  static String chatroomMessage({String chatroomId, String messageId}) =>
      'chatrooms/$chatroomId/messages/$messageId';

  static String post(String postId) => 'posts/$postId';
  static String posts() => 'posts/';

  static String postPicture(String postId) => 'posts/$postId';
}
