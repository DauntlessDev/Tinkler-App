
import 'package:meta/meta.dart';

//view model class
import 'package:stacked/stacked.dart';

class SearchViewModel extends StreamViewModel {
  // Stream<Search> searchName() {}

  @override
  Stream get stream => throw UnimplementedError();
}

class Search {
  final String name;
  final String photoUrl;
  Search({
    @required this.name,
    @required this.photoUrl,
  });
}
