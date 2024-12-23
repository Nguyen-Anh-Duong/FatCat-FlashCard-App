import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/viewmodels/create_deck_viewmodel.dart';
import 'package:FatCat/views/widgets/card_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                IconButton(
                  icon: const Icon(Icons.check, size: 32),
                  onPressed: () async {
                    await viewModel.saveDeck();
                    if (onDelete != null) onDelete!();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                // Header section (scrollable)
                Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleSection(viewModel),
                        const SizedBox(height: 16),
                        _buildDescriptionSection(viewModel),
                        const SizedBox(height: 16),
                        _buildLanguageSection(viewModel),
                        const SizedBox(height: 16),
                        const Text(
                          'Danh sách thẻ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Cards section (expandable list)
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: viewModel.cards.length,
                    cacheExtent: 500, // Cache khoảng 5-6 items

                    // Thêm clipBehavior để tránh render items không cần thiết
                    clipBehavior: Clip.hardEdge,

                    // Sử dụng addAutomaticKeepAlives để kiểm soát việc giữ state
                    addAutomaticKeepAlives: false,

                    // Sử dụng addRepaintBoundaries để tối ưu việc vẽ lại
                    addRepaintBoundaries: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CardEditWidget(
                          key: ValueKey('card_${index}'),
                          card: viewModel.cards[index],
                          onRemove: () => viewModel.removeCard(index),
                          onCardChanged: (card) =>
                              viewModel.updateCard(index, card),
                        ),
                      );
                    },
                  ),
                ),
              ],
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

  Widget _buildTitleSection(CreateOrUpdateDeckViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tiêu đề',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: viewModel.titleController,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 3.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.brown, width: 4.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(CreateOrUpdateDeckViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mô tả',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: viewModel.descriptionController,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 3.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.brown, width: 4.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection(CreateOrUpdateDeckViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLanguageDropdown(
          'Ngôn ngữ thuật ngữ',
          viewModel.selectedFrontLanguage,
          viewModel.setFrontLanguage,
        ),
        const SizedBox(height: 16),
        _buildLanguageDropdown(
          'Ngôn ngữ định nghĩa',
          viewModel.selectedBackLanguage,
          viewModel.setBackLanguage,
        ),
      ],
    );
  }

  Widget _buildLanguageDropdown(
    String label,
    String? value,
    void Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 3.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.brown, width: 4.0),
            ),
          ),
          items: ['Tiếng Việt', 'English', 'Japanese', 'Tiếng Trung']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) onChanged(newValue);
          },
        ),
      ],
    );
  }
}
