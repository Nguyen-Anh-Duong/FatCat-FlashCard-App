import 'package:FatCat/models/class_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/services/class_service.dart';
import 'package:FatCat/services/deck_service.dart';
import 'package:flutter/material.dart';
import 'package:FatCat/models/user_model.dart';

class ClassDetailViewmodel extends ChangeNotifier {
  final ClassService _classService = ClassService();
  ClassModel mClass;
  String? _error;
  bool _isLoading = false;
  List<DeckModel> _decks = [];
  bool get isLoading => _isLoading;
  List<DeckModel> get decks => _decks;
  String? get error => _error;
  List<UserModel> _classMembers = [];
  List<UserModel> get classMembers => _classMembers;

  Future<void> joinClass(String inviteCode) async {
    await _classService.joinClass(inviteCode);
  }

  ClassDetailViewmodel({required this.mClass}) {
    fetchDecks();
    print('====');
    print(mClass.id.toString());
    getClassMembers(mClass.id.toString());
  }

  Future<void> leaveClass() async {
    await _classService.leaveClass(mClass.id.toString());
  }

  Future<void> fetchDecks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 200));
      _decks = await DeckService.fetchDecks();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getClassMembers(String classId) async {
    print('111111111111111');
    try {
      _classMembers = await _classService.getClassMembers(classId);
      notifyListeners();
    } catch (e) {
      print('Error fetching class members: $e');
      rethrow;
    }
  }
}
