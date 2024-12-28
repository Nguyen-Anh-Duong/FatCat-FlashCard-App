import 'dart:io';

import 'package:FatCat/models/class_model.dart';
import 'package:FatCat/services/class_service.dart';
import 'package:FatCat/services/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ClassViewModel extends ChangeNotifier {
  ClassViewModel() {
    initData();
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();

  final ClassService _classService = ClassService();
  bool _isLoading = false;
  List<ClassModel> _ownClasses = [];
  List<ClassModel> _allClasses = [];

  bool get isLoading => _isLoading;
  List<ClassModel> get ownClasses => _ownClasses;
  List<ClassModel> get allClasses => _allClasses;

  Future<void> initData() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    try {
      await Future.wait([
        fetchOwnClasses(),
        fetchAllClasses(),
      ]);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOwnClasses() async {
    try {
      _ownClasses = await _classService.getOwnClasses();
      notifyListeners();
    } catch (e) {
      print('Error fetching own classes: $e');
    }
  }

  Future<void> fetchAllClasses() async {
    try {
      _allClasses = await _classService.getAllClasses();
    } catch (e) {
      print('Error fetching all classes: $e');
    }
  }

  Future<void> createClass(String name, String description) async {
    try {
      ClassModel newClass = await _classService.createClass(
        name: name.trim(),
        description: description.trim(),
      );
      if (newClass != null) {
        _ownClasses.add(newClass);
        notifyListeners();
      }
    } catch (e) {
      print('Error creating class: $e');
      rethrow;
    }
  }

  Future<void> joinClass(String codeInvite) async {
    try {
      await _classService.joinClass(codeInvite);
      await fetchOwnClasses();
      notifyListeners();
    } catch (e) {
      print('Error joining class: $e');
      rethrow;
    }
  }
}
