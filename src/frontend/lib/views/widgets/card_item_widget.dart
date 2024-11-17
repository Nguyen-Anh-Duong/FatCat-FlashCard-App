import 'package:FatCat/constants/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CardItemWidget extends StatelessWidget {
  final String question;
  final String answer;
  final String? question_language;
  final String? answer_language;
  const CardItemWidget({
    super.key,
    required this.question,
    required this.answer,
    this.question_language,
    this.answer_language,
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
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: IconButton(
                  icon: Icon(Icons.volume_up, color: AppColors.greyIcon),
                  onPressed: () async {
                    FlutterTts flutterTts = FlutterTts();
                    await flutterTts.setLanguage(question_language ?? "en-US");
                    await flutterTts.speak(question);
                  },
                ),
              ),
            ],
          ),
        ),
        back: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  width: 2, color: AppColors.borderCard.withOpacity(0.25))),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    answer,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: IconButton(
                  icon: Icon(Icons.volume_up, color: AppColors.greyIcon),
                  onPressed: () async {
                    FlutterTts flutterTts = FlutterTts();
                    await flutterTts.setLanguage(answer_language ?? "en-US");
                    await flutterTts.speak(answer);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
