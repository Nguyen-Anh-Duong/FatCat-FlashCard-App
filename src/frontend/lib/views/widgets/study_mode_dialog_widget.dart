import 'package:FatCat/viewmodels/study_mode_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:provider/provider.dart';

class StudyModeDialog extends StatelessWidget {
  final String deckId;
  const StudyModeDialog({
    super.key,
    required this.deckId,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StudyModeViewModel>(context);
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      title: Text('Chọn chế độ học $deckId'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.timeline),
            title: const Text('Học theo tiến độ'),
            onTap: () => viewModel.routeToIntermittentStudyScreen(context),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Tự học'),
            onTap: () => viewModel.routeToSelfStudyScreen(context),
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Học nhiều đáp án'),
            onTap: () {
              // Handle multiple choice mode
            },
          ),
        ],
      ),
    );
  }
}
