import 'package:injectable/injectable.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/chat.dart';
import 'package:tinkler/model/message.dart';

@lazySingleton
class AllChatService with ReactiveServiceMixin {
  AllChatService() {
    listenToReactiveValues([_listOfAllChats]);
  }

  RxValue<List<Chat>> _listOfAllChats = RxValue<List<Chat>>(initial: []);
  List<Chat> get getListOfAllChats => _listOfAllChats.value;
  // List<Chat> get getNonEmptyChats => _listOfAllChats.value;
  List<Chat> get getNonEmptyChats => _listOfAllChats.value.where((chat) {
        bool result = false;
        if (chat != null) {
          if (chat.lastMessage != null) {
            if (chat.lastMessage.time.isNotEmpty) {
              result = true;
            }
          }
        }

        return result;
      }).toList();

  void sort() {
    _listOfAllChats.value.sort((b, a) {
      DateTime firstTime = DateTime.parse(a.lastMessage.time);
      Duration firstDifference = firstTime.difference(DateTime.now());

      DateTime secondTime = DateTime.parse(b.lastMessage.time);
      Duration secondDifference = secondTime.difference(DateTime.now());

      return firstDifference.compareTo(secondDifference);
    });
  }


  void setLastMessageOfSpecificChat({String email, Message message}) {
    for (Chat chat in _listOfAllChats.value) {
      if (chat.profile.email == email) {
        chat.lastMessage = message;
        notifyListeners();
      }
    }
  }

  void addChatInList(Chat chat) {
    _listOfAllChats.value.add(chat);
    notifyListeners();
  }

  void clear() {
    _listOfAllChats.value.clear();
    notifyListeners();
  }
}
