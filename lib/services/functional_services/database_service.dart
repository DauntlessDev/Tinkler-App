import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/chatroom.dart';
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
      {@required String messageId, @required String message}) async {
    String chatroomId = _chatroom.chatroomId;
    await _service.setData(
      path:
          APIPath.chatroomMessage(chatroomId: chatroomId, messageId: messageId),
      data: {'message': message},
    );
  }

  Stream<Profile> messageStream() {
    String chatroomId = _chatroom.chatroomId;
    return _service.documentStreamNoID(
      path: APIPath.chatroomMessages(chatroomId),
      builder: (data) => Profile.fromMap(data),
    );
  }

  // Future<void> addProfile(Profile profile) async {
  //   String _uid = _user.uid;
  //   await _service.setData(
  //     path: APIPath.profile(_uid),
  //     data: profile.toMap(),
  //   );
  // }

  // Stream<Profile> chatStream() {
  //   String _uid = _user.uid;
  //   return _service.documentStreamNoID(
  //     path: APIPath.profile(_uid),
  //     builder: (data) => Profile.fromMap(data),
  //   );
  // }

  // }

  // Stream<Profile> chatroomStream(String otherEmail) {
  //   String _uid = _user.email;
  //   return _service.documentStreamNoID(
  //     path: APIPath.profile(_uid),
  //     builder: (data) => Profile.fromMap(data),
  //   );
  // }

  // @override
  // Future<void> deleteJob(Job job) async {
  //   // delete where entry.jobId == job.jobId
  //   final allEntries = await entriesStream(job: job).first;
  //   for (Entry entry in allEntries) {
  //     if (entry.jobId == job.id) {
  //       await deleteEntry(entry);
  //     }
  //   }
  //   // delete job
  //   await _service.deleteData(path: APIPath.job(uid, job.id));
  // }

  // @override
  // Stream<List<Job>> jobsStream() => _service.collectionStream(
  //       path: APIPath.jobs(uid),
  //       builder: (data, documentId) => Job.fromMap(data, documentId),
  //     );

  // @override
  // Stream<Job> jobStream({@required String jobId}) => _service.documentStream(
  //       path: APIPath.job(uid, jobId),
  //       builder: (data, documentId) => Job.fromMap(data, documentId),
  //     );

  // @override
  // Future<void> setEntry(Entry entry) async => await _service.setData(
  //       path: APIPath.entry(uid, entry.id),
  //       data: entry.toMap(),
  //     );

  // @override
  // Future<void> deleteEntry(Entry entry) async =>
  //     await _service.deleteData(path: APIPath.entry(uid, entry.id));

  // @override
  // Stream<List<Entry>> entriesStream({Job job}) =>
  //     _service.collectionStream<Entry>(
  //       path: APIPath.entries(uid),
  //       queryBuilder: job != null
  //           ? (query) => query.where('jobId', isEqualTo: job.id)
  //           : null,
  //       builder: (data, documentID) => Entry.fromMap(data, documentID),
  //       sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
  //     );

}
