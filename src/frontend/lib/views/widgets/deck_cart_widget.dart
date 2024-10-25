import 'package:FatCat/constants/card_data_test.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/views/screens/intermittent_study_screen.dart';
import 'package:flutter/material.dart';

class DeckCartWidget extends StatelessWidget {
  final DeckModel deck;
  const DeckCartWidget({
    super.key,
    required this.deck,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                IntermittentStudyScreen(cards: cardsForDecks[deck.id]!),
          ),
        );
      },
      child: Card(
        elevation: 6,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: Color.fromRGBO(49, 58, 89, 1),
            ),
          ),
          child: Column(
            children: [
              Text(
                deck.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                deck.description,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                deck.deck_cards_count,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                deck.createdAt.toString(),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
