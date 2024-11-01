import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/viewmodels/library_viewmodel.dart';
import 'package:FatCat/views/screens/not_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LibraryViewModel(),
      child: Consumer<LibraryViewModel>(builder: (context, viewModel, child) {
        if (viewModel.isConnected) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Library", style: AppTextStyles.boldText28SigmarOne),
            ),
          );
        }
        return const NotConnectionScreen(title: "Library");
      }),
    );
  }
}
