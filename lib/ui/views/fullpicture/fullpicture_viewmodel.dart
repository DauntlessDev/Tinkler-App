import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/state_services/current_picture_service.dart';

class FullPictureViewModel extends BaseViewModel {
  final _currentPicture = locator<CurrentPictureService>();

  String get imageUrl => _currentPicture.imageUrl;
}
