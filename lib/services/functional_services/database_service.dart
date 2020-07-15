import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/chatroom.dart';
import 'package:tinkler/model/message.dart';
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

  Future<void> addProfile(Profile profile) async {
    String _uid = _user.uid;
    await _service.setData(
      path: APIPath.userInfo(_uid),
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

  Future<List<Profile>> usersFuture() {
    return _service.collectionFuture<Profile>(
        path: APIPath.users(), builder: (data) => Profile.fromMap(data));
  }

  Future<void> addChatroom(Chatroom chatroom) async {
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

  Stream<List<Chatroom>> chatroomsStream() {
    return _service.collectionStreamNoID(
      path: APIPath.chatrooms(),
      builder: (data) => Chatroom.fromMap(data),
      queryBuilder: (query) => query.where('users', arrayContains: _user.email),
      isReversed: true,
    );
  }
}
