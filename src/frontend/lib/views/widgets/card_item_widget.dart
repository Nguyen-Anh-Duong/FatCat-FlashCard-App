import 'package:FatCat/constants/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CardItemWidget extends StatelessWidget {
  final String question;
  final String answer;
  const CardItemWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipCard(
        speed: 250,
        direction: FlipDirection.VERTICAL,
        front: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  width: 2, color: AppColors.borderCard.withOpacity(0.25))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                question,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        back: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  width: 2, color: AppColors.borderCard.withOpacity(0.25))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                answer,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
