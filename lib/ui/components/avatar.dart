import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String photoUrl;
  final double radius;

  const Avatar({this.photoUrl, @required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black12,
        //TODO: to be removed for ui designing only
        child: ClipOval(
          child: Image(
            image: AssetImage('assets/images/profile_1.jpg'),
            fit: BoxFit.contain,
          ),
        ),
        // backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
        // child: photoUrl.isEmpty ? Icon(Icons.person, size: radius) : null,
      ),
    );
  }
}
