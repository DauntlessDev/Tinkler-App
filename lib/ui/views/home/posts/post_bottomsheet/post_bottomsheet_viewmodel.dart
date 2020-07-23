import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

class PostBottomsheetViewModel extends BaseViewModel {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();

  String _input = '';
  String get input => _input;
  void setInput(String value) {
    _input = value;
    print(_input);
  }

  String generatedPostId({String posterEmail, String time}) =>
      posterEmail + time;

  Future<void> proceedPost() async {
    if (_input.isNotEmpty) {
      setBusy(true);
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      Profile currentProfile;

      await _database
          .profileFuture(email: _user.email)
          .then((value) => currentProfile = value.first);

      _database.addPost(
          post: Post(
        postId: generatedPostId(posterEmail: _user.email, time: time),
        description: _input,
        posterProfile: currentProfile,
        time: time,
        pictureUrl: '',
      ));

      setBusy(false);
    }
  }
}
