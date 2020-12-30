import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path();

    path1
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.4)
      ..lineTo(size.width * 0.8, size.height * 0.7)
      ..lineTo(size.width * 0.8, size.height)
      // ..quadraticBezierTo(
      //     size.width * 0.92, size.height * 0.85, size.width, size.height * 0.78)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
