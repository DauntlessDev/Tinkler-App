import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.email,
    @required this.uid,
  });

  final String uid;
  final String email;
}
