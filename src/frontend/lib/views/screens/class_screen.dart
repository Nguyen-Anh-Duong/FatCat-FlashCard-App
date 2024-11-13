import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/viewmodels/class_viewmodel.dart';
import 'package:FatCat/views/screens/not_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClassViewModel(),
      child: Consumer<ClassViewModel>(builder: (context, viewModel, child) {
        if (true) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Lớp học", style: AppTextStyles.boldText28),
                actions: [
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      await context.read<ClassViewModel>().fetchAllClasses();
                      await context.read<ClassViewModel>().fetchOwnClasses();
                    },
                  ),
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
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Lớp học của bạn'),
                    Tab(text: 'Lớp học nổi bật'),
                  ],
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackText,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 16,
                  ),
                  indicatorColor: AppColors.green, // Màu của thanh indicator
                  labelColor: AppColors.green, // Màu chữ tab đang chọn
                ),
              ),
              body: TabBarView(
                children: [
                  _buildYourClasses(),
                  _buildFeaturedClasses(),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildYourClasses() {
    return Consumer<ClassViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.ownClasses.isEmpty) {
          return const Center(
            child: Text('Bạn chưa tham gia lớp học nào'),
          );
        }

        return ListView.builder(
          itemCount: viewModel.ownClasses.length,
          itemBuilder: (context, index) {
            final classItem = viewModel.ownClasses[index];
            return ListTile(
              title: Text(classItem.name),
              subtitle: Text(classItem.description),
              trailing: Text('Mã lớp: ${classItem.codeInvite}'),
              onTap: () {
                // Navigate to class detail
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFeaturedClasses() {
    return Consumer<ClassViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.allClasses.isEmpty) {
          return const Center(
            child: Text('Không có lớp học nào'),
          );
        }

        return ListView.builder(
          itemCount: viewModel.allClasses.length,
          itemBuilder: (context, index) {
            final classItem = viewModel.allClasses[index];
            return ListTile(
              title: Text(classItem.name),
              subtitle: Text(classItem.description),
              trailing: Text('Mã lớp: ${classItem.codeInvite}'),
              onTap: () {
                // Navigate to class detail
              },
            );
          },
        );
      },
    );
  }
}
