import 'package:flutter/material.dart';

class DeckCartWidget extends StatelessWidget {
  final Map<String, dynamic> deck;
  const DeckCartWidget({
    super.key,
    required this.deck,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
              deck['deckName'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              deck['deckDescription'],
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
