import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/viewmodels/group_viewmodel.dart';
import 'package:FatCat/views/screens/not_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GroupViewModel(),
      child: Consumer<GroupViewModel>(builder: (context, viewModel, child) {
        if (viewModel.isConnected) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Group", style: AppTextStyles.boldText28SigmarOne),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: PopupMenuButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'create',
                        onTap: () {},
                        child: Text('Tạo nhóm'),
                      ),
                      PopupMenuItem(
                        value: 'join',
                        onTap: () {},
                        child: Text('Tham gia nhóm'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const NotConnectionScreen(title: "Group");
      }),
    );
  }
}
