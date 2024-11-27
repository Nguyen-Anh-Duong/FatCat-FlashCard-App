import 'package:FatCat/constants/seed_data.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/card_provider.dart';
import 'package:FatCat/models/deck_provider.dart';
import 'package:FatCat/viewmodels/screen_control_viewmodel.dart';
import 'package:FatCat/views/screens/home_screen.dart';
import 'package:FatCat/views/screens/bottom_navigation_bar.dart';
import 'package:FatCat/views/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FatCat/services/DatabaseHelper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  vah_test();
  await seedDatabaseForDecksControl();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ScreenControlViewModel(),
        ), // First provider
        ChangeNotifierProvider(
          create: (_) => DeckProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CardProvider(),
        ), // Second provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Nunito',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true),
      home: const ScreenControl(),
    );
  }
}