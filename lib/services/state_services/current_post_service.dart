import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';

@lazySingleton
class CurrentPostService with ReactiveServiceMixin {
  final _navigation = locator<NavigationService>();

  CurrentPostService() {
    listenToReactiveValues([_commentCount]);
  }

  String _postId;
  String get postId => _postId;
  void setPostId(String value) => _postId = value;

  RxValue<int> _commentCount = RxValue<int>(initial: 0);
  int get commentCount => _commentCount.value;

  void setCommentCount(int value) {
    _commentCount.value = value;
    notifyListeners();
  }

  void navigateToCommentSectionView() {
    _navigation.navigateTo(Routes.commentSectionViewRoute);
  }
}
