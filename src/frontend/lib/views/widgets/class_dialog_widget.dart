import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/viewmodels/class_viewmodel.dart';
import 'package:flutter/material.dart';

class ClassDialog {
  static Future<void> showCreateClassDialog(
      BuildContext context, ClassViewModel viewModel) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tạo nhóm mới'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Nhập tên nhóm',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Xử lý tạo nhóm
              Navigator.pop(context);
            },
            child: Text('Tạo'),
          ),
        ],
      ),
    );
  }

  static Future<void> showJoinClassDialog(
    BuildContext context,
    ClassViewModel viewModel,
  ) async {
    String? code;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tham gia nhóm'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Nhập mã nhóm',
            focusColor: AppColors.green,
          ),
          onChanged: (value) {
            code = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Hủy',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              if (code != null && code!.isNotEmpty) {
                viewModel.joinClass(code!);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Tham gia',
              style: TextStyle(color: AppColors.green),
            ),
          ),
        ],
      ),
    );
  }
}
