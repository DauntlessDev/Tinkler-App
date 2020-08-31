import 'package:flutter/material.dart';

class IndependentScale extends StatelessWidget {
  final Widget child;

  const IndependentScale({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: child,
    );
  }
}
