import 'package:FatCat/views/widgets/primary_button_widget.dart';
import 'package:FatCat/views/widgets/primary_outline_button.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmBottomSheet(BuildContext context, String title,
    {VoidCallback? onConfirm}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              primaryOutlineButton("Đóng", 150, () {
                Navigator.of(context).pop(false);
              }),
              primaryButton("Đồng ý", 150, () {
                if (onConfirm != null) {
                  onConfirm!();
                }
                Navigator.of(context).pop(true);
              })
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    ),
  );
}
