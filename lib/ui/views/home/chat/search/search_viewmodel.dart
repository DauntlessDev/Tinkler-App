import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/chatroom.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/database_service.dart';
import 'package:tinkler/services/current_user_service.dart';

class SearchViewModel extends BaseViewModel {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _navigation = locator<NavigationService>();

  String _input;
  String get input => _input;
  void setInput(String value) => _input = value;

  List<Profile> listOfUsers;
  void searchUsers() async {
    setBusy(true);
    listOfUsers = await _database.usersFuture().then((listOfProfile) =>
        listOfProfile
            .where((profile) => profile.displayName
                .toLowerCase()
                .contains(_input.toLowerCase()))
            .toList());

    setBusy(false);
    notifyListeners();
    print(listOfUsers);
  }

  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  sendMessage(String email) {
    setBusy(true);
    _database.addChatroom(Chatroom(
      users: [_user.email, email],
      chatroomID: getChatRoomId(_user.email, email),
    ));
    setBusy(false);

    _navigation.navigateTo(Routes.chatroomView);
  }
}
