import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/record.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_picture_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

class PostTileViewModel extends BaseViewModel {
  final _formatter = locator<FormatterService>();
  final _currentPicture = locator<CurrentPictureService>();
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();

  String formatDate(String firstTime) => _formatter.formatPostDate(firstTime);

  void updateCurrentImageUrl(String imageUrl) =>
      _currentPicture.updateCurrentImageUrl(imageUrl);

  void navigateToPictureView() => _currentPicture.navigateToPictureView();

  int likesCount = 0;
  bool isLiked = false;
  Future<void> checkIfLike(String postId, Post post) async {
    List<String> listOfLikes = await _database.allLikesFuture(postId: postId);
    isLiked = listOfLikes.contains(_user.email);

    likesCount = post.likesCount;
    notifyListeners();
  }

  Function onPressedLikeButton(Post post) {
    return isLiked ? () => deleteLike(post) : () => addLike(post);
  }

  void addLike(Post post) {
    print('addlike called');
    _database.addLike(
        postId: post.postId, likerEmail: Record(email: _user.email));
    _database.addPost(post: post.copyWith(likesCount: post.likesCount + 1));
    likesCount++;
    isLiked = true;
    notifyListeners();
  }

  void deleteLike(Post post) {
    print('deleteLike called');
    _database.deleteLike(postId: post.postId, email: _user.email);
    _database.addPost(post: post.copyWith(likesCount: post.likesCount - 1));
    likesCount--;

    isLiked = false;
    notifyListeners();
  }

  String likesText(int likesCount) {
    return likesCount == 0
        ? 'like'
        : likesCount == 1 ? '$likesCount like' : '$likesCount likes';
  }
}
