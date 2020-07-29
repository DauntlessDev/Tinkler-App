import 'package:stacked/stacked.dart';

import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class CheckProfileViewModel extends FutureViewModel<Profile> {
  final _database = locator<DatabaseService>();
  final _visitProfile = locator<VisitProfileService>();
  final _user = locator<CurrentUserService>();

  Future<Profile> profileFuture() async {
    setBusy(true);
    List<Profile> profileList =
        await _database.profileFuture(email: _visitProfile.email);
    setBusy(false);
    return profileList.first;
  }

  Profile get profile {
    return (data == null)
        ? Profile(
            caseSearch: [],
            uid: '',
            photoUrl: '',
            displayName: '',
            email: '',
            followers: 0,
            following: 0,
            posts: 0,
          )
        : Profile(
            caseSearch: data.caseSearch,
            uid: data.uid,
            photoUrl: data.photoUrl ?? '',
            email: data.email,
            displayName: data.displayName,
            followers: data.followers,
            following: data.following,
            posts: data.posts,
          );
  }

  List<PostProfile> ownPostProfileList = [];
  Future<List<Post>> ownPostFuture() async =>
      await _database.specificPostFuture(_visitProfile.email);
  List<Post> ownPostList = [];

  bool isFollowed = false;
  @override
  Future<Profile> futureToRun() async {
    _visitProfile.checkUserFollowing();
    isFollowed = await _visitProfile.isProfileFollowed(_visitProfile.email);

    ownPostList = await ownPostFuture();
    Profile profile = await profileFuture().then((value) => value);

    setPosts(ownPostList, profile);

    return profile;
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

  Function onPressed({String email, String uid}) {
    return () async {
      buttonFunction(email: email, uid: uid);
      isFollowed = await _visitProfile.isProfileFollowed(_visitProfile.email);
      print(isFollowed);
      notifyListeners();
    };
  }

  bool get isVisitingOwnProfile => _visitProfile.email == _user.email;
  Function buttonFunction({String email, String uid}) {
    return isVisitingOwnProfile
        ? null
        : isFollowed
            ? () =>
                _visitProfile.unfollowingUser(otherEmail: email, otherUid: uid)
            : () =>
                _visitProfile.followingUser(otherEmail: email, otherUid: uid);
  }

  String get buttonText => _visitProfile.buttonText(isFollowed);
}
