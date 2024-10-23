import 'package:FatCat/models/deck_provider.dart';
import 'package:FatCat/views/screens/decks%20management/available_decks/deck_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableDeckScreen extends StatelessWidget {
  const AvailableDeckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deckData = Provider.of<DeckProvider>(context).deckData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Available decks'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: deckData.length,
        itemBuilder: (context, index) {
          return DeckCartWidget(deck: deckData[index]);
        },
      ),
    );
  }
}
