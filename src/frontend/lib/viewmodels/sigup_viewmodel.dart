import 'package:FatCat/services/auth_service.dart';
import 'package:FatCat/views/screens/OTP_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class SignupViewModel extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  //
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLoading = false;

  // Getters
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isLoading => _isLoading;

  // Method to validate input
  String? validateInput() {
    _username = usernameController.text.trim();
    _password = passwordController.text.trim();
    _confirmPassword = confirmPasswordController.text.trim();
    _email = emailController.text.trim();
    if (_username.isEmpty) {
      return 'Tên người dùng không được để trống';
    }
    if (_email.isEmpty || !_email.contains('@')) {
      return 'Email không hợp lệ';
    }
    if (_password.isEmpty || _password.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    if (_password != _confirmPassword) {
      return 'Mật khẩu không khớp';
    }
    return null; // Input is valid
  }

  // Method to handle signup logic
  Future<void> signup(BuildContext context) async {
    // Start loading
    _isLoading = true;
    notifyListeners();

    try {
      final response = await AuthService.signUp(_email, _password, _username);
      if (response.statusCode == 200) {
        Map<String, String> data = {
          'name': _username,
          'email': _email,
          'password': _password
        };

        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: OtpScreen(data: data),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      // End loading
      _isLoading = false;
      notifyListeners();
    }
  }
}
