import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  AuthTextFormField({
    Key key,
    this.focusNode,
    this.keyBoardType = TextInputType.text,
    this.obscureText: false,
    @required this.onChanged,
    @required this.onEditingComplete,
    @required this.textInputAction,
    @required this.hintString,
    @required this.initialValue,
    @required this.iconData,
  }) : super(key: key);

  final FocusNode focusNode;
  final Function onChanged;
  final Function onEditingComplete;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final bool obscureText;

  final String hintString;
  final String initialValue;

  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      initialValue: initialValue,
      keyboardType: keyBoardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintString,
        hintStyle: TextStyle(color: Colors.grey),
        icon: Icon(
          iconData,
          //NOT WORKING IN FLUTTER DONT KNOW WHY :(
          color: focusNode.hasFocus ? Colors.blue[900] : Colors.grey,
        ),
        focusColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
      ),
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}
