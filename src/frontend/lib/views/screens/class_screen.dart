import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/viewmodels/class_viewmodel.dart';
import 'package:FatCat/views/screens/not_connection_screen.dart';
import 'package:FatCat/views/widgets/class_card_widget.dart';
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
                      await context.read<ClassViewModel>().initData();
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
          return const Center(
            child: CircularProgressIndicator(color: AppColors.green),
          );
        }

        return RefreshIndicator(
          color: AppColors.green,
          onRefresh: () => viewModel.initData(),
          child: viewModel.ownClasses.isEmpty
              ? ListView(
                  children: const [
                    Center(
                      child: Text('Bạn chưa tham gia lớp học nào'),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: viewModel.ownClasses.length,
                    itemBuilder: (context, index) {
                      final classItem = viewModel.ownClasses[index];
                      return ClassCardWidget(classItem: classItem);
                    },
                  ),
                ),
        );
      },
    );
  }

  Widget _buildFeaturedClasses() {
    return Consumer<ClassViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.green),
          );
        }

        return RefreshIndicator(
          color: AppColors.green,
          onRefresh: () => viewModel.initData(),
          child: viewModel.allClasses.isEmpty
              ? ListView(
                  children: const [
                    Center(
                      child: Text('Không có lớp học nào'),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: viewModel.allClasses.length,
                    itemBuilder: (context, index) {
                      final classItem = viewModel.allClasses[index];
                      return ClassCardWidget(classItem: classItem);
                    },
                  ),
                ),
        );
      },
    );
  }
}
