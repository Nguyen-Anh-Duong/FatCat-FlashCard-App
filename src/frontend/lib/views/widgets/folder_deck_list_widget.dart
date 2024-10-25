import 'package:FatCat/models/deck_provider.dart';
import 'package:FatCat/views/widgets/deck_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FolderDeckListWidget extends StatelessWidget {
  const FolderDeckListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deckData = Provider.of<DeckProvider>(context).deckData;
    return ListView.builder(
      itemCount: deckData.length,
      itemBuilder: (context, index) {
        return DeckCartWidget(deck: deckData[index]);
      },
    );
  }
}
