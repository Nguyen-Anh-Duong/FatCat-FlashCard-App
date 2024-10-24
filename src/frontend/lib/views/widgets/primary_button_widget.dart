import 'package:FatCat/constants/colors.dart';
import 'package:flutter/material.dart';

Widget primaryButton(String text, VoidCallback onPress) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.backgroundButtonColor,
          foregroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}
