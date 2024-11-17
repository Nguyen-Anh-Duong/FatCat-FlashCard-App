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
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              TextField(
                controller: viewModel.nameController,
                decoration: InputDecoration(
                    hintText: 'Nhập tên nhóm',
                    contentPadding: EdgeInsets.all(4)),
                cursorColor: AppColors.green,
              ),
              TextField(
                controller: viewModel.desController,
                decoration: InputDecoration(
                  hintText: 'Nhập mô tả nhóm',
                ),
                cursorColor: AppColors.green,
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              viewModel.createClass(
                  viewModel.nameController.text, viewModel.desController.text);
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
