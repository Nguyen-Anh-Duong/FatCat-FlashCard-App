import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/viewmodels/screen_control_viewmodel.dart';
import 'package:FatCat/views/screens/decks_control_screen.dart';
import 'package:FatCat/views/screens/class_screen.dart';
import 'package:FatCat/views/screens/home_screen.dart';
import 'package:FatCat/views/screens/library_screen.dart';
import 'package:FatCat/views/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class ScreenControl extends StatelessWidget {
  const ScreenControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenControlViewModel>(
      builder: (context, viewModel, child) => PersistentTabView(
        context,
        controller: viewModel.controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardAppears: true,
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        navBarHeight: 72,
        backgroundColor: Colors.white,
        isVisible: true,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            duration: Duration(milliseconds: 300),
            screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
          ),
        ),
        confineToSafeArea: true,
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property
        hideOnScrollSettings: HideOnScrollSettings(),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      Home(),
      DecksControl(),
      LibraryScreen(),
      ClassScreen(),
      Settings(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Trang chủ"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_stack),
        title: ("Bộ thẻ"),
        activeColorPrimary: Colors.brown,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_favorites),
        title: ("Thư viện"),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.group),
        title: ("Lớp học"),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Cài đặt"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
