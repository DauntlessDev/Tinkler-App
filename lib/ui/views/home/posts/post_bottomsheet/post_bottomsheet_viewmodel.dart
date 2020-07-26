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
  void setInput(String value) => _input = value;
  void inputClear() => _input = '';

  String generatedPostId({String posterEmail, String time}) =>
      posterEmail + time;

  String _imagePath = '';
  String get imagePath => _imagePath;
  void imagePathClear() => _imagePath = '';

  File _selectedImage;
  void selectedImageClear() => _selectedImage.delete();

  void fileReset() {
    inputClear();
    imagePathClear();
    if (_selectedImage != null) selectedImageClear();
  }

  Future<void> addImage() async {
    setBusy(true);
    try {
      File _image = await _database.getImage();
      _imagePath = _image.path;
      _selectedImage = _image;
      notifyListeners();
      print('image path : $_imagePath');
    } on PlatformException catch (e) {
      _dialog.showDialog(title: 'Profile', description: e.message);
    } catch (e) {}
    setBusy(false);
  }

  Future<void> proceedPost() async {
    if (_input.isNotEmpty) {
      setBusy(true);
      String time = DateTime.now().toIso8601String();
      String _postId = generatedPostId(posterEmail: _user.email, time: time);

      String _pictureDownloadUrl = "";
      if (_selectedImage != null) {
        _pictureDownloadUrl = await _database.uploadPostPicture(
            image: _selectedImage, postId: _postId);
      }

      _database.addPost(
          post: Post(
        posterEmail: _user.email,
        postId: _postId,
        description: _input,
        time: time,
        pictureUrl: _pictureDownloadUrl,
        commentsCount: 0,
        likesCount: 0,
      ));

      Profile currentProfileInfo;
      await _database
          .profileFuture(email: _user.email)
          .then((value) => currentProfileInfo = value.first);

      _database.setProfile(
          currentProfileInfo.copyWith(posts: currentProfileInfo.posts + 1));

      fileReset();
      notifyListeners();
      setBusy(false);
    }
  }
}
