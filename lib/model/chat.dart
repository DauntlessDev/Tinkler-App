import 'package:flutter/foundation.dart';
import 'package:tinkler/model/profile.dart';

import 'message.dart';

class Chat {
  Profile profile;
  Message lastMessage;

  Chat({
    @required this.profile,
    @required this.lastMessage,
  });
}
