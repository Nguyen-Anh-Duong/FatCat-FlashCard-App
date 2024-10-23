import 'package:FatCat/models/current_page_model.dart';
import 'package:FatCat/views/screens/cards_screen.dart';
import 'package:FatCat/views/screens/decks_control_screen.dart';
import 'package:FatCat/views/screens/home_screen.dart';
import 'package:FatCat/views/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenControl extends StatelessWidget {
  const ScreenControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurrentPageModel>(
        builder: (context, CurrentPageModel, child) {
          return IndexedStack(
            index: CurrentPageModel.currentIndex,
            children: const <Widget>[
              Home(),
              DecksControl(),
              CardsControl(),
              Settings(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: const Color.fromRGBO(96, 98, 131, 1),
        selectedItemColor: const Color.fromRGBO(253, 253, 253, 1),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 20,
        unselectedFontSize: 20,
        onTap: (index) => Provider.of<CurrentPageModel>(context, listen: false)
            .setPage(index),
        currentIndex: Provider.of<CurrentPageModel>(context).currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            label: 'Decks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
