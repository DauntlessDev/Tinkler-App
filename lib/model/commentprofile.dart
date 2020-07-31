import 'package:meta/meta.dart';
import 'package:tinkler/model/comments.dart';

import 'package:tinkler/model/profile.dart';

class CommentProfile {
  final Comment comment;
  final Profile profile;

  CommentProfile({@required this.comment, @required this.profile});
}
