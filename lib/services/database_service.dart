import 'package:flutter/foundation.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/model/user.dart';

import 'api_path.dart';
import 'firebase_service.dart';

abstract class Database {
  Future<void> addProfile(Profile profile);
  // Future<void> deleteJob(Job job);
  // Stream<List<Job>> jobsStream();
  // Stream<Job> jobStream({@required String jobId});

  // Future<void> setEntry(Entry entry);
  // Future<void> deleteEntry(Entry entry);
  // Stream<List<Entry>> entriesStream({Job job});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class DatabaseService implements Database {
  DatabaseService({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirebaseService.instance;

  @override
  Future<void> addProfile(Profile profile) async => await _service.setData(
        path: APIPath.profile(uid),
        data: profile.toMap(),
      );

  @override
  Stream<Profile> profileStream({@required String uid}) => _service.userStream(
        path: APIPath.profile(uid),
        builder: (data) => Profile.fromMap(data),
      );

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
