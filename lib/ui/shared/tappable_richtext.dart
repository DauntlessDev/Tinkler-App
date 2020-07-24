import 'package:flutter/material.dart';

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
          style: TextStyle(fontSize: 15),
          children: [
            TextSpan(
              text: firstString,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextSpan(
              text: secondString,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
