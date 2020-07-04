
import 'package:stacked/stacked.dart';

class  PostsViewModel extends BaseViewModel {
  String _title = 'Posts View';
  String get title => '$_title : $_counter';

  int _counter = 0;
  int get counter => _counter;

  // void updateCounter() {
  //   _counter++;
  //   notifyListeners();
  // }
}
