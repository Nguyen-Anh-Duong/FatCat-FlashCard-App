import 'dart:ui';

import 'package:flutter/material.dart';

class CatEarsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Bắt đầu từ góc trái dưới
    path.lineTo(0, size.height);

    // Vẽ phần thân chính
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // Vẽ tai trái
    path.lineTo(size.width * 0.6, 0);
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.3, // điểm điều khiển
      size.width * 0.4, 0, // điểm kết thúc
    );

    // Vẽ tai phải
    path.lineTo(size.width * 0.2, 0);
    path.quadraticBezierTo(
      size.width * 0.1, size.height * 0.3, // điểm điều khiển
      0, 0, // điểm kết thúc
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
