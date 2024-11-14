import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/viewmodels/deck_control_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecksControl extends StatelessWidget {
  const DecksControl({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DecksControlViewModel()..fetchDecks(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.backgroundScreen,
          appBar: AppBar(
            title: Text("Decks", style: AppTextStyles.boldText28),
            backgroundColor: AppColors.backgroundScreen,
            bottom: const TabBar(
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
              indicatorColor: Colors.brown,
              tabs: [
                Tab(text: 'Bộ thẻ của bạn'),
                Tab(text: 'Bộ thẻ đã tải'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildYourDecks(),
              _buildDownloadedDecks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYourDecks() {
    return Consumer<DecksControlViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.error != null) {
          return Center(child: Text('Error: ${viewModel.error}'));
        } else if (viewModel.decks.isEmpty) {
          return const Center(child: Text('No decks available.'));
        } else {
          return ListView.builder(
            itemCount: viewModel.decks.length,
            itemBuilder: (context, index) {
              final deck = viewModel.decks[index];
              return ListTile(
                title: Text(deck.name),
                subtitle: Text(deck.description),
                onTap: () {
                  // Handle deck tap
                },
              );
            },
          );
        }
      },
    );
  }

  Widget _buildDownloadedDecks() {
    return Center(child: Text("Downloaded Decks"));
  }
}
