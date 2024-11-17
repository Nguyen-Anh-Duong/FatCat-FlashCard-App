import 'package:flutter/material.dart';

class ActionDialogWidget extends StatelessWidget {
  final List<ActionDialogItem> items;
  final String? title;

  const ActionDialogWidget({
    Key? key,
    required this.items,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) => _buildItem(item, context)).toList(),
      ),
    );
  }

  Widget _buildItem(ActionDialogItem item, BuildContext context) {
    return ListTile(
      leading: Icon(item.icon, color: item.iconColor ?? Colors.black),
      title: Text(
        item.title,
        style: TextStyle(
          color: item.titleColor ?? Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        item.onTap();
      },
    );
  }
}

class ActionDialogItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;

  ActionDialogItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.titleColor,
  });
}
