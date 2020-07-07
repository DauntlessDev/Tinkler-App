import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/user.dart';

import 'authentication_service.dart';
import 'database_service.dart';

@lazySingleton
class UserService extends StreamViewModel {
  final _database = locator<DatabaseService>();
  final _auth = locator<AuthenticationService>();

  Stream<User> onAuthStateChanged() {
    // Future<User> user = _auth.currentUser();
    // return _database.profileStream(uid: null);
  }

  @override
  Stream<User> get stream => onAuthStateChanged();
}
