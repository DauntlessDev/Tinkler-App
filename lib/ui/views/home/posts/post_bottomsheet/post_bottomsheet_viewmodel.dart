import 'dart:io';

import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

class PostBottomsheetViewModel extends BaseViewModel {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _dialog = locator<DialogService>();

  String _input = '';
  String get input => _input;
  void setInput(String value) {
    _input = value;
    print(_input);
  }

  String generatedPostId({String posterEmail, String time}) =>
      posterEmail + time;

  String _photoUrl = '';
  Future<void> addImage() async {
    setBusy(true);
    try {
      File _image = await _database.getImage();
      String downloadUrl = await _database.uploadProfilePic(image: _image);

      _photoUrl = downloadUrl;
    } on PlatformException catch (e) {
      _dialog.showDialog(title: 'Profile', description: e.message);
    } catch (e) {}
    setBusy(false);
  }

  Future<void> proceedPost() async {
    if (_input.isNotEmpty) {
      setBusy(true);
      String time = DateTime.now().toIso8601String();
      Profile currentProfile;

      await _database
          .profileFuture(email: _user.email)
          .then((value) => currentProfile = value.first);

      _database.addPost(
          post: Post(
        posterEmail: _user.email,
        postId: generatedPostId(posterEmail: _user.email, time: time),
        description: _input,
        posterProfile: currentProfile,
        time: time,
        pictureUrl: _photoUrl,
        commentsCount: 0,
        likesCount: 0,
      ));

      _photoUrl = '';
      setBusy(false);
    }
  }
}
