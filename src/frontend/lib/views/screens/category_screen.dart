import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/viewmodels/category_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  final List<DeckModel> decks;
  const CategoryScreen(
      {super.key, required this.category, required this.decks});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryScreenViewModel(decks: decks),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Consumer<CategoryScreenViewModel>(
            builder: (context, viewModel, child) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: viewModel.decks.length,
                itemBuilder: (context, index) {
                  final deck = viewModel.decks[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(deck.name),
                      subtitle: Text('cards'),
                      onTap: () {},
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
