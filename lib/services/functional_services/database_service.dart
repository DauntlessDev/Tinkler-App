import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/chatroom.dart';
import 'package:tinkler/model/comments.dart';
import 'package:tinkler/model/record.dart';
import 'package:tinkler/model/message.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

import 'api_path.dart';
import 'firebase_service.dart';

@lazySingleton
class DatabaseService {
  final _service = locator<FirebaseService>();
  final _user = locator<CurrentUserService>();
  final _chatroom = locator<CurrentChatroomService>();

  Future<File> getImage() async {
    return await _service.getImage();
  }

  Future<String> uploadProfilePic({@required File image}) async {
    String _uid = _user.uid;
    return _service.uploadPic(image: image, path: APIPath.profilePic(_uid));
  }

  Future<String> uploadPostPicture(
      {@required File image, @required String postId}) async {
    return _service.uploadPic(image: image, path: APIPath.postPicture(postId));
  }

  Future<void> setProfile(Profile profile) async {
    await _service.setData(
      path: APIPath.userInfo(profile.uid),
      data: profile.toMap(),
    );
  }

  Stream<Profile> profileStream() {
    String _uid = _user.uid;
    return _service.documentStreamNoID(
      path: APIPath.userInfo(_uid),
      builder: (data) => Profile.fromMap(data),
    );
  }

  Future<List<Profile>> profileFuture({@required String email}) {
    return _service.collectionFuture<Profile>(
      path: APIPath.users(),
      builder: (data) => Profile.fromMap(data),
      queryBuilder: (query) => query.where('email', isEqualTo: email),
    );
  }

  Future<List<Profile>> usersFuture(String searchInput) {
    return _service.collectionFuture<Profile>(
        path: APIPath.users(),
        builder: (data) => Profile.fromMap(data),
        queryBuilder: (query) =>
            query.where('caseSearch', arrayContains: searchInput));
  }

  Future<void> addLike(
      {@required String postId, @required Record likerEmail}) async {
    await _service.setData(
      path: APIPath.likesSpecific(postId, likerEmail.email),
      data: likerEmail.toMap(),
    );
  }

  Future<void> deleteLike({@required String postId, String email}) async {
    await _service.deleteData(path: APIPath.likesSpecific(postId, email));
  }

  Future<List<String>> allLikesFuture({@required String postId}) {
    return _service.collectionFuture(
      path: APIPath.likes(postId),
      isReversed: true,
      builder: (data) => Record.fromMap(data).email,
    );
  }

  Future<void> addFollower(
      {@required String uid, @required Record follow}) async {
    await _service.setData(
      path: APIPath.followerSpecific(uid, follow.email),
      data: follow.toMap(),
    );
  }

  Future<void> addFollowing(
      {@required String uid, @required Record follow}) async {
    await _service.setData(
      path: APIPath.followingSpecific(uid, follow.email),
      data: follow.toMap(),
    );
  }

  Future<void> deleteFollower({@required String uid, String email}) async {
    await _service.deleteData(path: APIPath.followerSpecific(uid, email));
  }

  Future<void> deleteFollowing({@required String uid, String email}) async {
    await _service.deleteData(path: APIPath.followingSpecific(uid, email));
  }

  Stream<List<Record>> followingStream(
      {@required String uid, @required String email}) {
    return _service.collectionStreamNoID(
      path: APIPath.following(uid),
      isReversed: true,
      builder: (data) => Record.fromMap(data),
      queryBuilder: (query) => query.where('email', isEqualTo: email),
    );
  }

  Stream<List<String>> allFollowingStream({@required String uid}) {
    return _service.collectionStreamNoID(
      path: APIPath.following(uid),
      isReversed: true,
      builder: (data) => Record.fromMap(data).email,
    );
  }

  Future<List<String>> allFollowingFuture({@required String uid}) {
    return _service.collectionFuture(
      path: APIPath.following(uid),
      isReversed: true,
      builder: (data) => Record.fromMap(data).email,
    );
  }

  Future<List<String>> allFollowersFuture({@required String uid}) {
    return _service.collectionFuture(
      path: APIPath.followers(uid),
      isReversed: true,
      builder: (data) => Record.fromMap(data).email,
    );
  }

  Future<void> addComment({@required Comment comment}) async {
    await _service.setData(
      path: APIPath.comment(comment.commendId, comment.commentTime),
      data: comment.toMap(),
    );
  }

  Stream<List<Comment>> getCommentsStream({@required String postId}) {
    return _service.collectionStreamNoID(
      path: APIPath.comments(postId),
      builder: (data) => Comment.fromMap(data),
    );
  }

  Future<void> addChatroom({@required Chatroom chatroom}) async {
    await _service.setData(
      path: APIPath.chatroom(chatroom.chatroomID),
      data: chatroom.toMap(),
    );
  }

  Future<void> addMessage(
      {@required String messageId, @required Message message}) async {
    String chatroomId = _chatroom.chatroomId;
    await _service.setData(
      path:
          APIPath.chatroomMessage(chatroomId: chatroomId, messageId: messageId),
      data: message.toMap(),
    );
  }

  Stream<List<Message>> messagesStream() {
    String chatroomId = _chatroom.chatroomId;
    return _service.collectionStreamNoID(
      path: APIPath.chatroomMessages(chatroomId),
      builder: (data) => Message.fromMap(data),
      sort: (a, b) => a.time.compareTo(b.time),
      isReversed: true,
    );
  }

  Stream<List<Message>> messagesStreamInChat({@required String chatroomId}) {
    return _service.collectionStreamNoID(
      path: APIPath.chatroomMessages(chatroomId),
      builder: (data) => Message.fromMap(data),
      sort: (a, b) => a.time.compareTo(b.time),
      isReversed: true,
    );
  }

  Future<List<Message>> messagesFuture({@required String chatroomId}) {
    return _service.collectionFuture(
      path: APIPath.chatroomMessages(chatroomId),
      builder: (data) => Message.fromMap(data),
      sort: (a, b) => a.time.compareTo(b.time),
    );
  }

  Stream<List<Chatroom>> chatroomsStream() {
    return _service.collectionStreamNoID(
      path: APIPath.chatrooms(),
      builder: (data) => Chatroom.fromMap(data),
      queryBuilder: (query) => query.where('users', arrayContains: _user.email),
      isReversed: false,
    );
  }

  Future<void> deleteChatroom({String chatroomId}) async {
    await _service.deleteData(path: APIPath.chatroom(chatroomId));
  }

  Future<void> setPost({@required Post post}) async {
    await _service.setData(
      path: APIPath.post(post.postId),
      data: post.toMap(),
    );
  }

  Stream<List<Post>> postStream() {
    return _service.collectionStreamNoID(
      path: APIPath.posts(),
      builder: (data) => Post.fromMap(data),
      sort: (a, b) => a.time.compareTo(b.time),
      isReversed: true,
    );
  }

  Future<List<Post>> postFuture() {
    return _service.collectionFuture(
      path: APIPath.posts(),
      builder: (data) => Post.fromMap(data),
      sort: (a, b) => a.time.compareTo(b.time),
      isReversed: true,
    );
  }

  Stream<List<Post>> specificPostStream(String email) {
    return _service.collectionStreamNoID(
      path: APIPath.posts(),
      builder: (data) => Post.fromMap(data),
      sort: (a, b) => a.time.compareTo(b.time),
      queryBuilder: (query) => query.where('posterEmail', isEqualTo: email),
      isReversed: true,
    );
  }

  Future<List<Post>> specificPostFuture(String email) {
    return _service.collectionFuture(
      path: APIPath.posts(),
      builder: (data) => Post.fromMap(data),
      sort: (a, b) => a.time.compareTo(b.time),
      queryBuilder: (query) => query.where('posterEmail', isEqualTo: email),
      isReversed: true,
    );
  }
}
