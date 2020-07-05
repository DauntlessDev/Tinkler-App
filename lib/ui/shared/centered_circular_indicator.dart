import 'package:flutter/material.dart';

class CenteredCircularIndicator extends StatelessWidget {
  const CenteredCircularIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
