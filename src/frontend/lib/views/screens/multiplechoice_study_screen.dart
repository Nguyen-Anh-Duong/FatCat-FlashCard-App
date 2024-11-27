import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/viewmodels/mutiplechoice_study_viewmodel.dart';
import 'package:FatCat/views/screens/review_study_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultipleChoiceStudyScreen extends StatelessWidget {
  final List<CardModel> cards;
  const MultipleChoiceStudyScreen({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MultipleChoiceStudyViewModel(cards: cards),
      child: Consumer<MultipleChoiceStudyViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isStudyCompleted) {
            return ReviewStudyScreen(
              detailedAnswers: null,
              correctAnswers: viewModel.correctAnswers,
              incorrectAnswers: viewModel.wrongAnswers,
            );
          }
          return Scaffold(
            backgroundColor: AppColors.backgroundScreen,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top navigation bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 32,
                            color: AppColors.greyIcon,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Học chọn nhiều đáp án\n${viewModel.studiedCards} / ${viewModel.cards.length}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.settings,
                            size: 32,
                            color: AppColors.greyIcon,
                          ),
                          onPressed: () {},
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
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Text(
                        viewModel.currentQuestion,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildAnswerButton(context,
                                viewModel.currentAnswers[0], viewModel),
                            _buildAnswerButton(context,
                                viewModel.currentAnswers[1], viewModel),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            _buildAnswerButton(context,
                                viewModel.currentAnswers[2], viewModel),
                            _buildAnswerButton(context,
                                viewModel.currentAnswers[3], viewModel),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnswerButton(
    BuildContext context,
    String answer,
    MultipleChoiceStudyViewModel viewModel,
  ) {
    final size = MediaQuery.of(context).size;

    Color backgroundColor = AppColors.backgroundScreen;
    Color borderColor = Colors.grey.withOpacity(0.2);

    if (viewModel.answerStates.containsKey(answer)) {
      if (viewModel.answerStates[answer]!) {
        backgroundColor = Colors.green.withOpacity(0.6);
        borderColor = Colors.green;
      } else {
        backgroundColor = Colors.orange.withOpacity(0.6);
        borderColor = Colors.orange;
      }
    }

    return Expanded(
      child: SizedBox(
        height: size.height * 0.12,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: borderColor, width: 2),
              ),
            ),
            onPressed: () => viewModel.checkAnswer(answer),
            child: Text(
              answer,
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 3,
              style: TextStyle(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
