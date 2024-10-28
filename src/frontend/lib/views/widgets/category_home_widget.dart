import 'package:FatCat/utils/app_elevated_button_style.dart';
import 'package:flutter/material.dart';

class CategoryHomeWidget extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  const CategoryHomeWidget({
    super.key,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 100,
          ),
          child: ElevatedButton(
            style: AppElevatedButtonStyles.categoryHome,
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(iconPath, width: 72, height: 72),
            ),
          ),
        ),
      ),
    );
  }
}
