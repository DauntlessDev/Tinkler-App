import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';

@lazySingleton
class CommentSectionService extends ChangeNotifier {
  final _navigation = locator<NavigationService>();

  String _commentId;
  String get commentId => _commentId;
  void setCommentId(String value) => _commentId = value;

  void navigateToCommentSectionView() {
    _navigation.navigateTo(Routes.commentSectionViewRoute);
  }
}
