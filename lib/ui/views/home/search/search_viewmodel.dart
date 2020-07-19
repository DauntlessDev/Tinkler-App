import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

class SearchViewModel extends BaseViewModel {
  final _database = locator<DatabaseService>();

  String _input = '';
  String get input => _input;
  void setInput(String value) => _input = value;

  List<Profile> listOfUsers;
  void searchUsers() async {
    if (_input.isNotEmpty) {
      setBusy(true);
      try {
        listOfUsers = await _database.usersFuture().then((listOfProfile) =>
            listOfProfile
                .where((profile) => profile.displayName
                    .toLowerCase()
                    .contains(_input.toLowerCase()))
                .toList());

        notifyListeners();
        setBusy(false);
      } on PlatformException catch (e) {
        print(e.message);
      }
    }
  }

  Future<void> visitProfile(Profile otherProfile) async {
    //navigate to profile
  }
}
