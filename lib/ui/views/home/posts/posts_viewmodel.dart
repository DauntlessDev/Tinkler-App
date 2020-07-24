import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
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

  List<Post> _postList = [];
  void setPosts(List<Post> event) {
    print('event : $event');
    for (Post post in event) {
      print('postsss: $post');
      _postList.add(
        Post(
          description: post.description,
          posterProfile: post.posterProfile,
          postId: post.postId,
          time: post.time,
          pictureUrl: post.pictureUrl ?? '',
          commentsCount: post.commentsCount,
          likesCount: post.likesCount,
        ),
      );
    }
    notifyListeners();
  }

  List<Post> get postList => _postList;

  String formatTime(String time) => _formatter.formatDate(time);
}
