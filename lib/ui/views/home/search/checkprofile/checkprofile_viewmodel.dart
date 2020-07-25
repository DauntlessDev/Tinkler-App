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
            photoUrl: '',
            displayName: '',
            email: '',
            followers: 0,
            following: 0,
            posts: 0,
          )
        : Profile(
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
  @override
  Future<Profile> futureToRun() async {
    ownPostList = await ownPostFuture();
    Profile profile = await profileFuture().then((value) => value);
    setPosts(ownPostList, profile);
    return profile;
  }

  Future<void> setPosts(List<Post> event, Profile senderProfile) async {
    setBusy(true);
    print('event : $event');
    ownPostProfileList.clear();

    for (Post post in event) {
      print('postsss: $post');
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

  bool isVisitingOwnProfile() {
    return profile.email == _user.email;
  }

  void followUser() {
    print('follow userssss');
  }
}
