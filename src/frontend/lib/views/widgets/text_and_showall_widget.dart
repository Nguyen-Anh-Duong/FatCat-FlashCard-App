import 'package:FatCat/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class TextAndShowAllWidget extends StatelessWidget {
  final String text;
  final bool isShowAll;
  final VoidCallback onPressed;
  const TextAndShowAllWidget(
      {super.key,
      required this.text,
      this.isShowAll = true,
      this.onPressed = _defaultOnPressed});

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Text(text,
                style: isShowAll
                    ? AppTextStyles.normalText
                    : AppTextStyles.boldText20),
          ),
          if (isShowAll)
            TextButton(
              onPressed: onPressed,
              child: const Text('Xem tất cả', style: AppTextStyles.viewAllText),
            )
        ],
      ),
    );
  }
}
