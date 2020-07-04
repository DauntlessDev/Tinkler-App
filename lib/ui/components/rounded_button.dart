import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {@required this.color, @required this.onPressed, @required this.text});
  final Color color;
  final Function onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        color: this.color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: this.onPressed,
          minWidth: double.infinity,
          height: 42.0,
          child: Text(
            this.text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
