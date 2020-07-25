import 'package:meta/meta.dart';

import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/profile.dart';

class PostProfile {
  final Post post;
  final Profile posterProfile;

  PostProfile({@required this.post, @required this.posterProfile});
}
