

//view model class
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  String _title = 'Search View';
  String get title => '$_title : $_counter';

  int _counter = 0;
  int get counter => _counter;

  void updateCounter() {
    _counter++;
    notifyListeners();
  }
}


