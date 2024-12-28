import 'dart:convert';
import 'package:FatCat/services/class_service.dart';
import 'package:FatCat/services/user_local_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final String baseUrl =
      dotenv.get('BASE_URL') ?? 'http://localhost:3000/v1/api';

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
      };
  final storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/access/login'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['metadata'];
        final accessToken = responseData['accessToken'];
        final email = responseData['email'];
        final name = responseData['name'];

        await UserLocalService.saveUserInfo(accessToken, email, name);

        // await FirebaseMsg.saveTokenToDatabase(userId);
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  static Future<http.Response> signUp(
      String email, String password, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/access/register'),
        headers: _headers,
        body: json.encode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );
      print(response.body);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to sign up: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  static Future<bool> forgotPassword(String email) async {
    try {
      final Map<String, String> userLocal =
          await UserLocalService.getUserInfo();
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/access/reset-password'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode({"email": email}),
        );
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print(e);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyOTP(
      String email, String password, String name, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/access/verify-account'),
        headers: _headers,
        body: jsonEncode({
          "email": email,
          "otpCode": otp,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['metadata'];
        final name = responseData['name'];
        final accessToken = responseData['accessToken'];
        final email = responseData['email'];
        await UserLocalService.saveUserInfo(accessToken, email, name);
        final temp = await UserLocalService.getUserInfo();
        print('===$temp');
        return true;
      } else {
        print('Error verifying OTP: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

  static Future<void> resendOTP(String email) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/access/resend-code'),
        headers: _headers,
        body: jsonEncode({
          "email": email,
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> changePassword(String oldpass, String newpass) async {
    try {
      final _headers = await ClassService.getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/access/change-password'),
        headers: _headers,
        body: jsonEncode({"oldPassword": oldpass, "newPassword": newpass}),
      );
      if (response.statusCode == 200) {
        return true;
      }
      print(response.body);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
