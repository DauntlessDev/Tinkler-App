import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/state_services/current_picture_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

class PostTileViewModel extends BaseViewModel {
  final _formatter = locator<FormatterService>();
  final _currentPicture = locator<CurrentPictureService>();

  String formatDate(String firstTime) => _formatter.formatPostDate(firstTime);

  void updateCurrentImageUrl(String imageUrl) =>
      _currentPicture.updateCurrentImageUrl(imageUrl);

  void navigateToPictureView() => _currentPicture.navigateToPictureView();
}
