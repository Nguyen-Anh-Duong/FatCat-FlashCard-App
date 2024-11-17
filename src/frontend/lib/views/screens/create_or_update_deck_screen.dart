import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FatCat/viewmodels/create_deck_viewmodel.dart';
import 'package:FatCat/views/widgets/card_edit_widget.dart';

class CreateOrUpdateDeckScreen extends StatelessWidget {
  final String? deckId;
  final DeckModel? initialDeck;
  final List<CardModel>? initialCards;
  final VoidCallback? onDelete;
  const CreateOrUpdateDeckScreen({
    Key? key,
    this.deckId,
    this.initialDeck,
    this.initialCards,
    this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateOrUpdateDeckViewModel(
        deckId: deckId,
        initialDeck: initialDeck,
        initialCards: initialCards,
      ),
      child: Consumer<CreateOrUpdateDeckViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundScreen,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                deckId == null ? 'Tạo bộ thẻ mới' : 'Chỉnh sửa bộ thẻ',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: const Icon(Icons.check, size: 32),
                    onPressed: () async {
                      await viewModel.saveDeck();
                      if (onDelete != null) {
                        onDelete!();
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiêu đề',
                          style: TextStyle(
                            color: AppColors.blackText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: viewModel.titleController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.brown,
                                width: 4.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mô tả',
                          style: TextStyle(
                            color: AppColors.blackText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: viewModel.descriptionController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.brown,
                                width: 4.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.cards.length,
                    itemBuilder: (context, index) {
                      return CardEditWidget(
                        card: viewModel.cards[index],
                        onRemove: () => viewModel.removeCard(index),
                        onCardChanged: (card) =>
                            viewModel.updateCard(index, card),
                      );
                    },
                  ),
                  const SizedBox(height: 80), // Space for FAB
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.brown,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () => viewModel.addCard(),
            ),
          );
        },
      ),
    );
  }
}
