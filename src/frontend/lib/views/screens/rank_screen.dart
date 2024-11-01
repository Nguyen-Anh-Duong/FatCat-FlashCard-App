import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/views/widgets/cat_clip_widget.dart';
import 'package:FatCat/views/widgets/study_streak_widget.dart';
import 'package:flutter/material.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Bảng xếp hạng',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Xếp hạng của bạn', style: AppTextStyles.boldText20),
              Image.asset(
                'assets/icons/rank.png',
                height: 150,
                width: 150,
              ),
              SizedBox(height: 20),
              Text(
                '1100',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text('No.99',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: StudyStreakWidget(
                  streak: 3,
                  streakStartAt: DateTime.now().add(
                    const Duration(days: 2),
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
