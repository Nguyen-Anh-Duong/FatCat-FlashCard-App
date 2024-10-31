import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/card_provider.dart';
import 'package:FatCat/utils/app_elevated_button_style.dart';
import 'package:FatCat/views/screens/intermittent_study_screen.dart';
import 'package:FatCat/views/screens/self_study_screen.dart';
import 'package:FatCat/views/widgets/primary_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/card_item_widget.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardData = Provider.of<CardProvider>(context, listen: false).cardData;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Cards"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            primaryOutlineButton(
              'Học theo tiến độ',
              double.infinity,
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return IntermittentStudyScreen(cards: cardData);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            primaryOutlineButton(
              'Tự học',
              double.infinity,
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SelfStudyScreen(cards: cardData);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            primaryOutlineButton(
              'Học chọn nhiều đáp án',
              double.infinity,
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SelfStudyScreen(cards: cardData);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CardItemWidget(
                    question: cardData[index].question,
                    answer: cardData[index].answer,
                  );
                },
                itemCount: cardData.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
