import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:observable_ish/value/value.dart';

@lazySingleton
class CommentSectionService with ReactiveServiceMixin {
  CommentSectionService() {
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
}
