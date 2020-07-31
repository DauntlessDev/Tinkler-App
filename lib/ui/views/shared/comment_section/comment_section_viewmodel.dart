import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/commentprofile.dart';
import 'package:tinkler/model/comments.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_post_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class CommentSectionViewModel extends StreamViewModel<List<Comment>> {
  final _database = locator<DatabaseService>();
  final _navigation = locator<NavigationService>();
  final _visitProfile = locator<VisitProfileService>();
  final _user = locator<CurrentUserService>();
  final _formatter = locator<FormatterService>();
  final _currentPost = locator<CurrentPostService>();

  String _postId;

  @override
  Stream<List<Comment>> get stream => getCommentsStream();
  Stream<List<Comment>> getCommentsStream() {
    _postId = _currentPost.currentPostId;

    _database.getCommentsStream(postId: _postId).listen((event) {
      setPosts(event);
    });
    return _database.getCommentsStream(postId: _postId);
  }

  List<Comment> get commentList => data;

  List<CommentProfile> commentprofileList = [];
  Future<void> setPosts(List<Comment> event) async {
    setBusy(true);
    print('commentlist : $event');
    commentprofileList.clear();
    for (Comment comment in event) {
      commentprofileList.add(CommentProfile(
          comment: Comment(
            commendId: comment.commendId,
            commentContent: comment.commentContent,
            commentTime: comment.commentTime,
            senderEmail: comment.senderEmail,
          ),
          profile: await _database
              .profileFuture(email: comment.senderEmail)
              .then((value) => value.first)));
    }

    notifyListeners();
    setBusy(false);
    print('model isbusy: $isBusy');
  }

  String _input = '';
  String get input => _input;
  void setInput(String value) => _input = value;

  Future<void> sendComment() async {
    if (_input.isNotEmpty) {
      setBusy(true);
      _currentPost.incrementCommentCount();

      Comment comment = Comment(
          commendId: _postId,
          commentContent: _input,
          commentTime: DateTime.now().toIso8601String(),
          senderEmail: _user.email);

      await _database.addComment(comment: comment);
      await _database.setPost(
          post: _currentPost.currentPost
              .copyWith(commentsCount: _currentPost.currentPostCommentCount));
      setBusy(false);

      _input = '';
      notifyListeners();
    }
  }

  String formatDate(String firstTime) {
    return _formatter.formatDate(firstTime);
  }

  Future<void> visitProfile(String email) async {
    _visitProfile.addVisitProfileEmail(email);
    _navigation.navigateTo(Routes.checkProfileViewRoute);
  }
}
