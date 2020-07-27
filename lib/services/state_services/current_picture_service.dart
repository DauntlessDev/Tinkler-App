import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';

@lazySingleton
class CurrentPictureService extends ChangeNotifier {
  final _navigation = locator<NavigationService>();

  String _imageUrl;
  String get imageUrl => _imageUrl;

  Future<void> updateCurrentImageUrl(String imageUrl) async {
    _imageUrl = imageUrl;
    print('current image url : $_imageUrl');

    notifyListeners();
  }

  void navigateToPictureView() {
    _navigation.navigateTo(Routes.fullPictureViewRoute);
  }
}
