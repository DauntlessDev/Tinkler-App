import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/user_service.dart';

import 'api_path.dart';
import 'firebase_service.dart';

@lazySingleton
class DatabaseService {
  final _service = locator<FirebaseService>();
  final _user = locator<UserService>();

  Future<File> getImage() async {
    return await _service.getImage();
  }

  Future uploadProfilePic(
      {@required File image, @required Function onComplete}) async {
    String _uid = _user.uid;
    return _service.uploadPic(
        image: image, path: APIPath.profilePic(_uid), onComplete: onComplete);
  }

  // Future<void> addProfile(Profile profile) async {
  //   String _uid = _user.uid;
  //   await _service.setData(
  //     path: APIPath.profile(_uid),
  //     data: profile.toMap(),
  //   );
  // }

  // Stream<Profile> profileStream() {
  //   String _uid = _user.uid;
  //   return _service.userStream(
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
