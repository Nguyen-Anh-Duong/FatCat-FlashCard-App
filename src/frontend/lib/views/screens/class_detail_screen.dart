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
      create: (_) => ClassDetailViewmodel(),
      child: Consumer<ClassDetailViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Deck Detail"),
            ),
            body: Center(
              child: Column(
                children: [
                  Text('${mClass.id}'),
                  Text('${mClass.name}'),
                  Text('${mClass.description}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
