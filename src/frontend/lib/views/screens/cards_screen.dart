import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/card_provider.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/views/screens/intermittent_study_screen.dart';
import 'package:FatCat/views/screens/self_study_screen.dart';
import 'package:FatCat/views/widgets/action_button_widget.dart';
import 'package:FatCat/views/widgets/text_and_showall_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../widgets/card_item_widget.dart';

class CardsScreen extends StatelessWidget {
  final DeckModel deck;
  const CardsScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    print(deck.name);
    print(deck.description);
    print(deck.is_published);
    print(deck.deck_cards_count);
    print(deck.createdAt);
    print(deck.updatedAt);

    final cardData = Provider.of<CardProvider>(context, listen: false).cardData;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cards",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deck.name,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Admin tạo',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${deck.deck_cards_count} Thuật ngữ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(deck.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(height: 20),
              const Text(
                'Chọn chế độ học',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              actionButtonWidget(
                  pathName: 'mode_red.png',
                  text: "Tự học",
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: SelfStudyScreen(cards: cardData),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              actionButtonWidget(
                  pathName: 'mode_blue.png',
                  text: "Học theo tiến trình",
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: IntermittentStudyScreen(cards: cardData),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              actionButtonWidget(
                  pathName: 'mode_green.png',
                  text: "Học chọn nhiều đáp án",
                  onTap: () {}),
              SizedBox(
                height: 20,
              ),
              Text(
                'Tất cả thuật ngữ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CardItemWidget(
                    question: cardData[index].question,
                    answer: cardData[index].answer,
                  );
                },
                itemCount: cardData.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
