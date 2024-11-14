import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/class_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClassService {
  final String baseUrl = dotenv.get('BASE_URL') ?? 'http://localhost:3000';
  final String authorization = dotenv.get('AUTHORIZATION') ??
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNzMxMzc5MDA2LCJleHAiOjE3MzkxNTUwMDZ9.UCUJ512XTdkciDexOcNRzRQ6SStmlSju9IdtFbyYdEk';

  // Headers cho API calls
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'authorization': authorization,
      };

  // Lấy tất cả các lớp
  Future<List<ClassModel>> getAllClasses() async {
    print(baseUrl);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/class'),
        headers: _headers,
      );
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
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/class'),
        headers: _headers,
        body: json.encode({
          'name': name,
          'description': description,
        }),
      );

      if (response.statusCode == 201) {
        return ClassModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create class: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create class: $e');
    }
  }

  // Tham gia lớp học
  Future<void> joinClass(String codeInvite) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/classes/$codeInvite'),
        headers: _headers,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to join class: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to join class: $e');
    }
  }

  // Xóa lớp học
  Future<void> deleteClass(String classId) async {
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
  Future<List<dynamic>> getClassMembers(String classId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/classes/$classId/members'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to fetch class members: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch class members: $e');
    }
  }

  // Lấy decks của lớp
  Future<List<dynamic>> getClassDecks(String classId) async {
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
