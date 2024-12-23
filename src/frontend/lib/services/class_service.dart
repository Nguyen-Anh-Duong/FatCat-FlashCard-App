import 'dart:convert';
import 'package:FatCat/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/class_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClassService {
  final String baseUrl =
      dotenv.get('BASE_URL') ?? 'http://localhost:3000/v1/api';
  static final storage = FlutterSecureStorage();
  static Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  static Future<Map<String, String>> getHeaders() async {
    final token = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
  }

  // Headers cho API calls

  // Lấy tất cả các lớp
  Future<List<ClassModel>> getAllClasses() async {
    final headers = await getHeaders();
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/class'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 5));
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> classesData = jsonData['metadata'];
        return classesData.map((json) => ClassModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch classes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch classes: $e');
    }
  }

  // Lấy lớp học của user hiện tại
  Future<List<ClassModel>> getOwnClasses() async {
    final _headers = await getHeaders();
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/class/own_classes'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> classesData = jsonData['metadata'];
        print(response.body);
        return classesData.map((json) => ClassModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch own classes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch own classes: $e');
    }
  }

  // Tạo lớp mới
  Future<ClassModel> createClass({
    required String name,
    required String description,
  }) async {
    final _headers = await getHeaders();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/class'),
        headers: _headers,
        body: json.encode({
          'name': name,
          'description': description,
        }),
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        return ClassModel.fromJson(data['metadata']);
      } else {
        throw Exception('Failed to create class: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create class: $e');
    }
  }

  // Tham gia lớp học
  Future<void> joinClass(String codeInvite) async {
    final _headers = await getHeaders();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/class/$codeInvite'),
        headers: _headers,
      );
      print(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to join class: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to join class: $e');
    }
  }

  // Xóa lớp học
  Future<void> deleteClass(String classId) async {
    final _headers = await getHeaders();
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/classes/$classId'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete class: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete class: $e');
    }
  }

  // Lấy thành viên của lớp
  Future<List<UserModel>> getClassMembers(String classId) async {
    final _headers = await getHeaders();
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/class/$classId/members'),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> membersData = json.decode(response.body);
        final List<dynamic> data = membersData['metadata']['members'];
        List<UserModel> members =
            data.map((item) => UserModel.fromJson(item)).toList();

        return members;
      } else {
        throw Exception(
            'Failed to fetch class members: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch class members: $e');
    }
  }

  // Rời lớp
  Future<void> leaveClass(String classId) async {
    final _headers = await getHeaders();
    await http.delete(Uri.parse('$baseUrl/class/leave/$classId'),
        headers: _headers);
  }

  // Lấy decks của lớp
  Future<List<dynamic>> getClassDecks(String classId) async {
    final _headers = await getHeaders();
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/class/$classId/decks'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch class decks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch class decks: $e');
    }
  }
}
