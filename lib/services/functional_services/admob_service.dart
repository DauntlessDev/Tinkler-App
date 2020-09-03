import 'dart:io';

import 'package:injectable/injectable.dart';

@lazySingleton
class AdmobService {
  String getBannerAdUnitId() {
    if (Platform.isAndroid) {
      // String _testAds = 'ca-app-pub-3940256099942544/6300978111';
      String _devAds = 'ca-app-pub-2751621661703939/4903212476';

      return _devAds;
    } else if (Platform.isIOS) {
      return 'has-no-id-yet';
    }
    return null;
  }

  String getAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2751621661703939~5898058938';
    } else if (Platform.isIOS) {
      return 'has-no-id-yet';
    }
    return null;
  }
}
