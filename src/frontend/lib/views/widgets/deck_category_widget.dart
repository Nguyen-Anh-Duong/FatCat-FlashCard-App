import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/viewmodels/study_mode_viewmodel.dart';
import 'package:FatCat/views/screens/self_study_screen.dart';
import 'package:FatCat/views/widgets/study_mode_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeckCategoryWidget extends StatelessWidget {
  final String name;
  final String deckId;
  final String description;
  final String userCreate;
  final VoidCallback onPressed;
  const DeckCategoryWidget({
    super.key,
    required this.name,
    required this.description,
    required this.userCreate,
    required this.onPressed,
    required this.deckId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.blackText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              side: BorderSide(
                color: const Color.fromARGB(255, 99, 99, 99).withOpacity(0.25),
                width: 2,
              ),
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 8.0, right: 40.0),
                          child: Text(
                            name,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          description,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      userCreate,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.blackText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: AppColors.greyIcon,
                size: 32,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => StudyModeViewModel(deckId: deckId),
                    child: StudyModeDialog(
                      deckId: deckId,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
