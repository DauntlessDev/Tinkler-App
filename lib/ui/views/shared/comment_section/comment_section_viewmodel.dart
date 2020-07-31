import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/comments.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_picture_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class CommentSectionViewModel extends StreamViewModel<List<Comment>> {
  final _database = locator<DatabaseService>();
  final _navigation = locator<NavigationService>();
  final _visitProfile = locator<VisitProfileService>();
  final _user = locator<CurrentUserService>();
  final _formatter = locator<FormatterService>();

  @override
  Stream<List<Comment>> get stream => getCommentsStream();
  Stream<List<Comment>> getCommentsStream() {
    return _database.getCommentsStream(postId: 'postId');
  }
  List<Comment> get commentList => data;

  String _input = '';
  String get input => _input;
  void setInput(String value) => _input = value;

  Future<void> sendComment() async {
    if (_input.isNotEmpty) {
      Comment comment = Comment(
          commendId: 'postId',
          commentContent: _input,
          commentTime: DateTime.now().toIso8601String(),
          senderEmail: _user.email);

      await _database.addComment(comment: comment);

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
