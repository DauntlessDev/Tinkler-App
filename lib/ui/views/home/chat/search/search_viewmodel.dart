import 'package:meta/meta.dart';

//view model class
import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/database_service.dart';

class SearchViewModel extends BaseViewModel {
  final _database = locator<DatabaseService>();

  String _input;
  String get input => _input;
  void setInput(String value) => _input = value;

  List<Profile> listOfUsers;
  void searchUsers() async {
    setBusy(true);
    listOfUsers = await _database.usersFuture().then((listOfProfile) =>
        listOfProfile
            .where((profile) => profile.displayName.toLowerCase().contains(_input.toLowerCase()))
            .toList());

    setBusy(false);
    notifyListeners();
    print(listOfUsers);
  }
}
