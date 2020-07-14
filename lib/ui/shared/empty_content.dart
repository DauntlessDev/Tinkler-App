import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  EmptyContent(
      {this.message = 'Page still don\'t have content',
      this.title = 'Empty Page'});
  final String message;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 13, color: Colors.black),
          ),
          Text(
            message,
            style: TextStyle(
                fontSize: 11,
                // fontWeight: FontWeight.bold,
                color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
