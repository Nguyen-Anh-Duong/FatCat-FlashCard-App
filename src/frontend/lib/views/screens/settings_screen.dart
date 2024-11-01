import 'package:FatCat/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings ", style: AppTextStyles.boldText28SigmarOne),
      ),
    );
  }
}
