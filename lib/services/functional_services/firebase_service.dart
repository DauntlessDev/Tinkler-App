import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@lazySingleton
class FirebaseService {
  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = Firestore.instance.document(path);
    await reference.setData(data);
  }

  Future<void> deleteData({@required String path}) async {
    final reference = Firestore.instance.document(path);
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.documents
          .map((snapshot) => builder(snapshot.data, snapshot.documentID))
          .where((value) => value != null)
          .toList();

      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<List<T>> collectionStreamNoID<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
    bool isReversed = false,
  }) {
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.documents
          .map((snapshot) => builder(snapshot.data))
          .where((value) => value != null)
          .toList();

      if (sort != null) {
        result.sort(sort);
      }

      if (isReversed) {
        List<T> reversedResult = result.reversed.toList();
        return reversedResult;
      } else {
        return result;
      }
    });
  }

  Future<List<T>> collectionFuture<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
    bool isReversed = false,
  }) {
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    try {
      final Future<QuerySnapshot> snapshots = query.getDocuments();
      return snapshots.then((snapshot) {
        final result = snapshot.documents
            .map((snapshot) => builder(snapshot.data))
            .where((value) => value != null)
            .toList();

        if (sort != null) {
          result.sort(sort);
        }

        if (isReversed) {
          List<T> reversedResult = result.reversed.toList();
          return reversedResult;
        } else {
          return result;
        }
      });
    } catch (e) {
      print(e);
      Future<List<T>> emptyList;
      return emptyList;
    }
  }

  Stream<T> documentStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = Firestore.instance.document(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();

    return snapshots
        .map((snapshot) => builder(snapshot.data, snapshot.documentID));
  }

  Stream<T> documentStreamNoID<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data),
  }) {
    final DocumentReference reference = Firestore.instance.document(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();

    return snapshots.map((snapshot) => builder(snapshot.data));
  }

  Future<T> documentFuture<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data),
  }) {
    final DocumentReference reference = Firestore.instance.document(path);
    final Future<DocumentSnapshot> snapshot = reference.get();

    return snapshot.then((snapshot) => builder(snapshot.data));
  }

  Future<File> getImage() async {
    ImagePicker _imagePicker = ImagePicker();
    PickedFile pickImage =
        await _imagePicker.getImage(source: ImageSource.gallery);

    File image = File(pickImage.path);
    return image;
  }

  Future<String> uploadPic({
    @required File image,
    @required String path,
  }) async {
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$path.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(image);

    await task.onComplete.then((value) => null);
    return await FirebaseStorage.instance
        .ref()
        .child('$path.jpg')
        .getDownloadURL();
  }
}
