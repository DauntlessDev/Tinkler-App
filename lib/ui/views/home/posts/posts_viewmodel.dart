import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

class PostsViewModel extends FutureViewModel {
  final _database = locator<DatabaseService>();
  final _formatter = locator<FormatterService>();
  final _user = locator<CurrentUserService>();

  @override
  Future futureToRun() => _setUpPostView();

  Future<void> _setUpPostView() async {
    List<String> followedEmailList = [_user.email];
    followedEmailList.addAll(
      await _database.allFollowingFuture(uid: _user.uid),
    );

    _database.postFuture().then((postList) {
      List<Post> followedPostList = [];
      if (postList != null) {
        for (Post post in postList) {
          if (followedEmailList.contains(post.posterEmail)) {
            followedPostList.add(post);
          }
        }
      }
      setPosts(followedPostList);
    });
  }

  List<PostProfile> _postprofileList = [];
  Future<void> setPosts(List<Post> event) async {
    setBusy(true);
    _postprofileList.clear();
    for (Post post in event) {
      _postprofileList.add(PostProfile(
          post: Post(
            description: post.description,
            posterEmail: post.posterEmail,
            postId: post.postId,
            time: post.time,
            pictureUrl: post.pictureUrl ?? '',
            commentsCount: post.commentsCount,
            likesCount: post.likesCount,
          ),
          posterProfile: await _database
              .profileFuture(email: post.posterEmail)
              .then((value) => value.first)));
    }

    notifyListeners();
    setBusy(false);
    print('model isbusy: $isBusy');
  }

  List<PostProfile> get postprofileList => _postprofileList;
  String formatTime(String time) => _formatter.formatDate(time);

  Future<void> reloadPage() async => await futureToRun();
}
