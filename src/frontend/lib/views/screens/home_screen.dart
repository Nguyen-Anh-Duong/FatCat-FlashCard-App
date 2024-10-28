import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/views/screens/bottom_navigation_bar.dart';
import 'package:FatCat/views/widgets/category_home_widget.dart';
import 'package:FatCat/views/widgets/curved_clipper_widget.dart';
import 'package:FatCat/views/widgets/deck_cart_widget.dart';
import 'package:FatCat/views/widgets/deck_home_item_widget.dart';
import 'package:FatCat/views/widgets/deck_item_widget.dart';
import 'package:FatCat/views/widgets/folder_deck_list_widget.dart';
import 'package:FatCat/views/widgets/study_streak_widget.dart';
import 'package:FatCat/views/widgets/text_and_showall_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipPath(
                clipper: CurvedClipper(),
                child: Container(
                  color: AppColors.backgroundButtonColor,
                  height: 160.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Fat Cat',
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.notifications,
                                size: 32,
                                color: AppColors.white,
                              ),
                              onPressed: () {
                                //todo open notification dialog
                              },
                            ),
                          ],
                        )
                      ],
                    )),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const TextAndShowAllWidget(text: 'Thư mục'),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const DeckHomeItemWidget(
                            name: "English",
                            description: 'Tieng Anh',
                            userCreate: 'Admin');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const TextAndShowAllWidget(text: 'Streak', isShowAll: false),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: StudyStreakWidget(
                    streak: 3,
                    streakStartAt: DateTime.now().add(const Duration(days: 2))),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextAndShowAllWidget(
                  text: 'Duyệt theo chủ đề', isShowAll: false),
              GridView.builder(
                padding: const EdgeInsets.only(left: 8, right: 8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final List<String> icons = [
                    'assets/icons/language.png',
                    'assets/icons/math.png',
                    'assets/icons/science.png',
                    'assets/icons/art.png',
                    'assets/icons/literary.png',
                    'assets/icons/unknown.png',
                  ];
                  final List<String> labels = [
                    'Ngôn ngữ',
                    'Toán học',
                    'Khoa học',
                    'Nghệ thuật',
                    'Văn học',
                    'Khác',
                  ];
                  return Column(
                    children: [
                      CategoryHomeWidget(iconPath: icons[index]),
                      Text(labels[index],
                          style: AppTextStyles.categoryHomeText),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
