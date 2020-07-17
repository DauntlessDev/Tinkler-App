import 'package:flutter/foundation.dart';
import 'package:tinkler/model/profile.dart';

import 'message.dart';

class Chat {
  final Profile profile;
  final Message lastMessage;

  const Chat({
    @required this.profile,
    @required this.lastMessage,
  });
}
