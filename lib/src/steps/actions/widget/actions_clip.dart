import 'package:flutter/widgets.dart';

class ActionsClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    double sideRadius = 20;

    path.moveTo(0, sideRadius);
    //TOP ARC
    path.quadraticBezierTo(size.width / 2, 0, size.width, sideRadius);
    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
