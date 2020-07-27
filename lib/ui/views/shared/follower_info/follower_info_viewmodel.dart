import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class FollowerInfoViewModel extends FutureViewModel {
  final _visitProfile = locator<VisitProfileService>();

  void checkFollowing() {}

  @override
  Future futureToRun() {}
}
