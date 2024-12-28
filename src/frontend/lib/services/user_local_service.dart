import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLocalService {
  static final storage = FlutterSecureStorage();

  static Future<void> logout() async {
    try {
      await storage.deleteAll();
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  static Future<void> saveUserInfo(
      String accessToken, String email, String name) async {
    try {
      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'name', value: name);
    } catch (e) {
      print('Error saving user info: $e');
    }
  }

  static Future<Map<String, String>> getUserInfo() async {
    try {
      String accessToken = await storage.read(key: 'accessToken') ?? '';
      String email = await storage.read(key: 'email') ?? '';
      String name = await storage.read(key: 'name') ?? '';

      Map<String, String> data = {
        'accessToken': accessToken,
        'email': email,
        'name': name
      };
      return data;
    } catch (e) {
      print('Error retrieving user info: $e');
      return {};
    }
  }
}
