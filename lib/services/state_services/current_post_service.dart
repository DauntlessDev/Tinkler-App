import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/post.dart';

@lazySingleton
class CurrentPostService with ReactiveServiceMixin {
  final _navigation = locator<NavigationService>();

  CurrentPostService() {
    listenToReactiveValues([_currentPost]);
  }

  RxValue<Post> _currentPost = RxValue<Post>(
      initial: Post(
          commentsCount: 0,
          description: '',
          likesCount: 0,
          pictureUrl: '',
          posterEmail: '',
          postId: '',
          time: ''));
  Post get currentPost => _currentPost.value;
  void setCurrentPost(Post value) {
    print('current post: $value');
    _currentPost.value = value;
    notifyListeners();
  }

  String get currentPostId => _currentPost.value.postId;
  int get currentPostCommentCount => _currentPost.value.commentsCount;

  void incrementCommentCount() {
    _currentPost.value.commentsCount += 1;
    notifyListeners();
  }

  void navigateToCommentSectionView() {
    _navigation.navigateTo(Routes.commentSectionViewRoute);
  }


  
}
