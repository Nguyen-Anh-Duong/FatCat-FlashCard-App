import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/class_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/viewmodels/class_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassDetailScreen extends StatelessWidget {
  final ClassModel mClass;
  const ClassDetailScreen({super.key, required this.mClass});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClassDetailViewmodel(mClass: mClass),
      child: Consumer<ClassDetailViewmodel>(
        builder: (context, viewModel, child) {
          return DefaultTabController(
            length: 2, // Number of tabs
            child: Scaffold(
              appBar: AppBar(
                title: Text("${mClass.name}"),
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
                          value: 'leave',
                          onTap: () {
                            viewModel.leaveClass();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Rời nhóm',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'share',
                          onTap: () {},
                          child: Text(
                            'Chia sẻ',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                bottom: TabBar(
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackText,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 16,
                  ),
                  indicatorColor: AppColors.green,
                  labelColor: AppColors.green,
                  tabs: [
                    Tab(
                      text: "Decks",
                    ),
                    Tab(text: "Members"),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  DecksTab(mClass: mClass), // Tab 1: Decks
                  MembersTab(), // Tab 2: Members
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DecksTab extends StatelessWidget {
  final ClassModel mClass;
  const DecksTab({super.key, required this.mClass});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('${mClass.id}'),
          Text('${mClass.name}'),
          Text('${mClass.description}'),
        ],
      ),
    );
  }
}

class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Members content goes here"),
    );
  }
}
