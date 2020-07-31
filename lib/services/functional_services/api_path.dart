class APIPath {
  static String users() => 'users/';
  static String userInfo(String uid) => 'users/$uid';

  static String profilePic(String uid) => 'profilePics/$uid';

  static String likesSpecific(String postId, String email) =>
      'likes/$postId/likes/$email';

  static String likes(String postId) => 'likes/$postId/likes/';

  static String followerSpecific(String uid, String email) =>
      'followers/$uid/followers/$email';
  static String followers(String uid) => 'followers/$uid/followers/';

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

  static String comment(String commentId, String time) =>
      'comment/$commentId/comment/$time';
  static String comments(String commentId) => 'comment/$commentId/comment';

  static String postPicture(String postId) => 'posts/$postId';
}
