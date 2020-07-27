import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';

class ProfileContentViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  void navigateToFollowersInfo() {
    _navigation.navigateTo(Routes.followerInfoViewRoute);
  }

  void navigateToFollowingInfo() {
    _navigation.navigateTo(Routes.followingInfoViewRoute);
  }
}
