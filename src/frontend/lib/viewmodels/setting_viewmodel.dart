import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/services/card_service.dart';
import 'package:FatCat/services/user_local_service.dart';
import 'package:FatCat/views/screens/change_password_screen.dart';
import 'package:FatCat/views/screens/forgot_password_screen.dart';
import 'package:FatCat/views/screens/intermittent_study_screen.dart';
import 'package:FatCat/views/screens/login_screen.dart';
import 'package:FatCat/views/screens/self_study_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class SettingViewModel extends ChangeNotifier {
  bool _notificationEnabled = true;
  bool _darkModeEnabled = false;
  bool _isLoggedIn = false;
  Map<String, dynamic> userInfo = {};

  bool get isLoggedIn => _isLoggedIn;
  bool get notificationEnabled => _notificationEnabled;

  SettingViewModel() {
    checkLoginStatus();
  }
  void updateUserInfo(Map<String, String> newUserInfo) {
    userInfo = newUserInfo;
    print('OKKK OTP');
    notifyListeners();
  }

  void logout() {
    UserLocalService.logout();
    userInfo = {};
    _isLoggedIn = false;
    notifyListeners();
    Fluttertoast.showToast(
      msg: "Logged out successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
    );
  }

  void routeToForgotPass(BuildContext context) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: ForgotPassword(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void routeToChangePass(BuildContext context) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: ChangePassWordScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Future<void> checkLoginStatus() async {
    final fetchUserInfo = await UserLocalService.getUserInfo();
    _isLoggedIn = fetchUserInfo['name']?.isNotEmpty == true;
    userInfo.addAll(fetchUserInfo);
    print('User info: ${userInfo['email']} -- islogin$isLoggedIn');
    notifyListeners();
  }

  void routeToLogin(BuildContext context) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: LoginScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
