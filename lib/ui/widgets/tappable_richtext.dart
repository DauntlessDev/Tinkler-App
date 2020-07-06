import 'package:flutter/material.dart';

import '../../constants.dart';

class TappableRichText extends StatelessWidget {
  const TappableRichText({
    Key key,
    this.onTap,
    this.firstString,
    this.secondString,
  }) : super(key: key);
  final Function onTap;
  final String firstString;
  final String secondString;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: blackColor, fontSize: 15),
          children: [
            TextSpan(text: firstString),
            TextSpan(
              text: secondString,
              style: boldTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
