import 'package:FatCat/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class TextAndShowAllWidget extends StatelessWidget {
  final String text;
  final bool isShowAll;
  const TextAndShowAllWidget(
      {super.key, required this.text, this.isShowAll = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: isShowAll
                  ? AppTextStyles.normalText
                  : AppTextStyles.boldText20),
          if (isShowAll)
            const Text('Xem tất cả', style: AppTextStyles.viewAllText)
        ],
      ),
    );
  }
}
