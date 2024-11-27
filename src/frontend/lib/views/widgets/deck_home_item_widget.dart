import 'package:FatCat/constants/colors.dart';
import 'package:flutter/material.dart';

class DeckHomeItemWidget extends StatelessWidget {
  final String name;
  final String description;
  final String userCreate;
  final String? cardCount;
  final VoidCallback onPressed;
  final Color? color;
  const DeckHomeItemWidget({
    super.key,
    required this.name,
    required this.description,
    required this.userCreate,
    required this.onPressed,
    this.cardCount,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.blackText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(
            color: const Color.fromARGB(255, 99, 99, 99).withOpacity(0.25),
            width: 2,
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name.length > 13
                              ? '${name.substring(0, 13)}...'
                              : name,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (cardCount != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: color?.withOpacity(0.1) ??
                                    Colors.purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${cardCount} thẻ',
                                style: TextStyle(
                                  color: color ?? Colors.purple,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Text(
                  'Bạn đã tạo',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
