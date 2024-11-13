import 'package:FatCat/views/screens/review_study_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:provider/provider.dart';
import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/viewmodels/intermittent_study_view_model.dart';

class IntermittentStudyScreen extends StatelessWidget {
  final List<CardModel> cards;

  const IntermittentStudyScreen({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IntermittentStudyViewModel(cards: cards),
      child: Consumer<IntermittentStudyViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isStudyCompleted) {
            return ReviewStudyScreen(
              detailedAnswers: viewModel.detailedAnswers,
              correctAnswers: null,
              incorrectAnswers: null,
            );
          }
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Column(
                children: [
                  // Top navigation
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          '${viewModel.studiedCards} / ${viewModel.totalCards}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            // Handle settings action
                          },
                        ),
                      ],
                    ),
                  ),
                  // Thanh progress
                  LinearProgressIndicator(
                    value: viewModel.studiedCards / viewModel.cards.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.progressBarColor),
                  ),
                  const SizedBox(height: 16),
                  // Card Swiper
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 630,
                        width: 390,
                        child: CardSwiper(
                          controller: viewModel.cardSwiperController,
                          cardsCount: viewModel.cards.length,
                          isLoop: false,
                          numberOfCardsDisplayed: 2,
                          scale: 1,
                          backCardOffset: const Offset(0, 0),
                          allowedSwipeDirection:
                              const AllowedSwipeDirection.none(),
                          duration: const Duration(milliseconds: 200),
                          onSwipe: viewModel.onSwipe,
                          cardBuilder: (context, index, _, __) {
                            return FlipCard(
                              key: viewModel.cardKeys[index],
                              front: _buildCardSide(
                                  viewModel.cards[index].question),
                              back:
                                  _buildCardSide(viewModel.cards[index].answer),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Bottom navigation
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: viewModel.showAnswer
                        ? _buildAnswerOptions(viewModel)
                        : _buildShowAnswerButton(viewModel, context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardSide(String content) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildShowAnswerButton(
      IntermittentStudyViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          viewModel.toggleShowAnswer();
          if (!viewModel.isCurrentCardAnswered) {
            viewModel.flipCurrentCard(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.backgroundButtonColor,
          foregroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text(
          'Hiện đáp án',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(IntermittentStudyViewModel viewModel) {
    return Row(
      children: [
        _buildOptionButton(
            'Học lại', AppColors.red, () => viewModel.answerCard(0)),
        _buildOptionButton(
            'Khó', AppColors.orange, () => viewModel.answerCard(1)),
        _buildOptionButton(
            'Tốt', AppColors.blue, () => viewModel.answerCard(2)),
        _buildOptionButton(
            'Dễ', AppColors.green, () => viewModel.answerCard(3)),
      ],
    );
  }

  Widget _buildOptionButton(String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
