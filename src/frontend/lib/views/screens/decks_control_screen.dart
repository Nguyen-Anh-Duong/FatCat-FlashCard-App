import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/viewmodels/deck_control_viewmodel.dart';
import 'package:FatCat/views/screens/cards_screen.dart';
import 'package:FatCat/views/screens/create_or_update_deck_screen.dart';
import 'package:FatCat/views/widgets/deck_lib_widget.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class DecksControl extends StatelessWidget {
  const DecksControl({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DecksControlViewModel()..fetchData(),
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: CreateOrUpdateDeckScreen(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            backgroundColor: Colors.brown,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Tạo bộ thẻ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
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
          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.fetchDecks();
            },
            child: Center(
              child: Text('Error: ${viewModel.error}'),
            ),
          );
        } else if (viewModel.decks.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.fetchDecks();
            },
            child: const Center(
              child: Text('Không có bộ thẻ nào.'),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.fetchDecks();
            },
            child: ListView.builder(
              itemCount: viewModel.decks.length,
              itemBuilder: (context, index) {
                final deck = viewModel.decks[index];
                return DeckLibWidget(
                  color: Colors.brown,
                  deck: deck,
                  onTap: () async {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: CardsScreen(
                        deck: deck,
                        isLocal: true,
                        onDelete: () {
                          viewModel.fetchData();
                        },
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildDownloadedDecks() {
    return Consumer<DecksControlViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.error != null) {
          return RefreshIndicator(
              onRefresh: () async {
                await viewModel.fetchDecksDownloaded();
              },
              child: Center(
                child: Text('Error: ${viewModel.error}'),
              ));
        } else if (viewModel.decks.isEmpty) {
          return RefreshIndicator(
              onRefresh: () async {
                await viewModel.fetchDecksDownloaded();
              },
              child: const Center(
                child: Text('Không có bộ thẻ nào.'),
              ));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.fetchDecksDownloaded();
            },
            child: ListView.builder(
              itemCount: viewModel.decksDownloaded.length,
              itemBuilder: (context, index) {
                final deck = viewModel.decksDownloaded[index];
                return DeckLibWidget(
                  color: Colors.brown,
                  deck: deck,
                  onTap: () async {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: CardsScreen(
                        deck: deck,
                        isLocal: true,
                        onDelete: () async {
                          await viewModel.fetchData();
                        },
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
