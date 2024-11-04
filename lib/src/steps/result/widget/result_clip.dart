import 'package:flutter/widgets.dart';

class ResultClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    double midWidth = size.width / 2;
    double midHeight = size.height / 2;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, midHeight);

    path.quadraticBezierTo(midWidth, size.height, 0, midHeight);

    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
