import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/viewmodels/category_screen_viewmodel.dart';
import 'package:FatCat/views/widgets/deck_category_widget.dart';
import 'package:FatCat/views/widgets/deck_home_item_widget.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(category,
              style: const TextStyle(
                  color: AppColors.blackText, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Consumer<CategoryScreenViewModel>(
            builder: (context, viewModel, child) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: viewModel.decks.length,
                itemBuilder: (context, index) {
                  final deck = viewModel.decks[index];
                  return DeckCategoryWidget(
                      name: deck.name,
                      description: deck.description,
                      userCreate: "chua test",
                      onPressed: () {},
                      deckId: deck.id);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
