import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

class PostsViewModel extends StreamViewModel {
  final _database = locator<DatabaseService>();
  final _formatter = locator<FormatterService>();

  @override
  Stream get stream => _getPostStream();

  Stream<List<Post>> _getPostStream() {
    _database.postStream().listen((event) {
      if (event != null) setPosts(event);
    });

    return _database.postStream();
  }

  List<PostProfile> _postprofileList = [];
  Future<void> setPosts(List<Post> event) async {
    setBusy(true);
    _postprofileList.clear();
    print('event : $event');

    for (Post post in event) {
      print('postsss: $post');
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
    setBusy(false);
    notifyListeners();
    print('model isbusy: $isBusy');
  }

  List<PostProfile> get postprofileList => _postprofileList;
  String formatTime(String time) => _formatter.formatDate(time);
}
