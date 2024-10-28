import 'package:FatCat/models/card_provider.dart';
import 'package:FatCat/views/screens/intermittent_study_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/card_item_widget.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardData = Provider.of<CardProvider>(context, listen: false).cardData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cards"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return IntermittentStudyScreen(cards: cardData);
                    },
                  ),
                );
              },
              child: const SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.credit_card),
                    Text("Flashcards"),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.credit_card),
                    Text("Flashcards"),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.credit_card),
                    Text("Flashcards"),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.credit_card),
                    Text("Flashcards"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 500,
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
