import 'package:flutter/material.dart';
import 'log_in_screen.dart';
import 'sign_up_screen.dart';
import 'change_password_screen.dart';
import 'package:FatCat/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  final String username;
  final String email;
  final bool isLoggedIn; // Thêm trạng thái đăng nhập

  SettingsScreen({required this.username, required this.email, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
        Card(
        elevation: 4.0,
        margin: const EdgeInsets.only(bottom: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 30.0,
            child: const Icon(
              Icons.person,
              size: 40.0,
              color: Colors.grey,
            ),
          ),
          title: Text(
            username,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            email,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Chế độ tối'),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
          if (!isLoggedIn) ...[
            ListTile(
              leading: const Icon(Icons.app_registration),
              title: const Text('Đăng ký'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Đăng nhập'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Đổi mật khẩu'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Đăng xuất'),
            onTap: () {
              _navigateToLoginScreen(context);
            },
          ),
        ],
      ),
    );
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}

