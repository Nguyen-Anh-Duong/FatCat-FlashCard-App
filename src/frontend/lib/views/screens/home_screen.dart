import 'package:FatCat/views/screens/bottom_navigation_bar.dart';
import 'package:FatCat/views/widgets/study_streak_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FatCat"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StudyStreakWidget(
                  streak: 3,
                  streakStartAt:
                      DateTime.now().subtract(const Duration(days: 2))),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const ScreenControl(),
    );
  }
}
