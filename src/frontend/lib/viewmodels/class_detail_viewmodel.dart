import 'package:FatCat/models/class_model.dart';
import 'package:FatCat/services/class_service.dart';
import 'package:flutter/material.dart';

class ClassDetailViewmodel extends ChangeNotifier {
  final ClassService _classService = ClassService();
  final ClassModel mClass;

  ClassDetailViewmodel({required this.mClass});

  Future<void> leaveClass() async {
    await _classService.leaveClass(mClass.id.toString());
  }
}
