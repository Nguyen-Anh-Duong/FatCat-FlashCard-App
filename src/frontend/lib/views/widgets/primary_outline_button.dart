import 'package:FatCat/constants/colors.dart';
import 'package:flutter/material.dart';

Widget primaryOutlineButton(String text, double width, VoidCallback onPress) {
  return SizedBox(
    height: 50,
    width: width,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
              color: AppColors.backgroundButtonColor, width: 2),
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.backgroundButtonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.blackText,
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
