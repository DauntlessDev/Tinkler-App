import 'dart:io';

import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/functional_services/authentication_service.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/all_chat_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/theme/app_theme_service.dart';

class ProfileViewModel extends StreamViewModel<Profile> {
  final _auth = locator<AuthenticationService>();
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _dialog = locator<DialogService>();
  final _theme = locator<AppThemeService>();
  final _chatlist = locator<AllChatService>();

  Stream<Profile> profileStream() => _database.profileStream();
  Stream<List<Post>> ownPostStream() =>
      _database.specificPostStream(_user.email);
  List<Post> ownPostList = [];

  List<PostProfile> ownPostProfileList = [];

  @override
  Stream<Profile> get stream {
    ownPostStream().listen((event) {
      if (event != null) {
        ownPostList = event;
      }
    });

    profileStream().listen((event) {
      if (event != null) {
        setPosts(ownPostList, event);
      }
    });
    return profileStream();
  }

  Future<void> setPosts(List<Post> event, Profile senderProfile) async {
    setBusy(true);
    ownPostProfileList.clear();

    for (Post post in event) {
      ownPostProfileList.add(
        PostProfile(
            post: Post(
              description: post.description,
              posterEmail: post.posterEmail,
              postId: post.postId,
              time: post.time,
              pictureUrl: post.pictureUrl ?? '',
              commentsCount: post.commentsCount,
              likesCount: post.likesCount,
            ),
            posterProfile: senderProfile),
      );
    }
    notifyListeners();
    setBusy(false);
  }

  Profile get profile {
    return (data == null)
        ? Profile(
            uid: '',
            photoUrl: '',
            displayName: '',
            email: '',
            followers: 0,
            following: 0,
            posts: 0,
          )
        : Profile(
            uid: data.uid,
            photoUrl: data.photoUrl ?? '',
            caseSearch: data.caseSearch,
            email: data.email,
            displayName: data.displayName,
            followers: data.followers,
            following: data.following,
            posts: data.posts,
          );
  }

  void toggleDarkMode(bool value) {
    _theme.updateTheme(value);
    notifyListeners();
  }

  Future<void> changeProfile() async {
    setBusy(true);
    try {
      File _image = await _database.getImage();
      String downloadUrl = await _database.uploadProfilePic(image: _image);

      await _database.addProfile(profile.copyWith(photoUrl: downloadUrl));
      notifyListeners();
    } on PlatformException catch (e) {
      _dialog.showDialog(title: 'Profile', description: e.message);
    } catch (e) {}
    setBusy(false);
  }

  Future<void> signOut() async {
    try {
      DialogResponse decision = await _dialog.showConfirmationDialog(
        title: 'Log-out',
        description: 'Are you sure in logging out?',
        confirmationTitle: 'Confirm',
        cancelTitle: 'Cancel',
      );

      if (decision.confirmed) {
        await _auth.signOut();
        _chatlist.clear();
        _user.updateCurrentUserInfo(User(email: '', uid: ''));
      }
    } on PlatformException catch (e) {
      _dialog.showDialog(
        title: 'Sign-up Failed',
        description: e.message,
      );
    }
  }
}
