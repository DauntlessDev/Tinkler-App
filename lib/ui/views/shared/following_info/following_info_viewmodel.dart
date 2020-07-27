import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class FollowingInfoViewModel extends FutureViewModel {
  final _visitProfile = locator<VisitProfileService>();

  String get appbarTitle => 'Follow Info';

  void checkFollowing() {
    
  }

  @override
  Future futureToRun() {}
}
