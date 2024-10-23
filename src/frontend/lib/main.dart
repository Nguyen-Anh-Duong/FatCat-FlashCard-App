import 'package:FatCat/models/current_page_model.dart';
import 'package:FatCat/models/deck_provider.dart';
import 'package:FatCat/views/screens/screen_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CurrentPageModel()), // First provider
        ChangeNotifierProvider(
            create: (_) => DeckProvider()), // Second provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          unselectedIconTheme: IconThemeData(
            size: 25,
            color: Color.fromRGBO(96, 98, 131, 1),
          ),
          selectedIconTheme: IconThemeData(
            size: 30,
            color: Color.fromRGBO(253, 253, 253, 1),
          ),
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        useMaterial3: true,
      ),
      home: const ScreenControl(),
    );
  }
}
