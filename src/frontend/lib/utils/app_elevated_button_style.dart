import 'package:FatCat/constants/colors.dart';
import 'package:flutter/material.dart';

class AppElevatedButtonStyles {
  static final categoryHome = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    side: BorderSide(
      color: const Color.fromARGB(255, 99, 99, 99).withOpacity(0.25),
      width: 2,
    ),
  );
}
