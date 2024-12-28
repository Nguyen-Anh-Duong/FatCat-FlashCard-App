// import 'package:FatCat/main.dart';
// import 'package:FatCat/models/card_model.dart';
// import 'package:flutter/material.dart';
// import 'package:FatCat/views/screens/intermittent_study_screen.dart';
// import 'package:FatCat/views/screens/self_study_screen.dart';
// import 'package:FatCat/views/screens/review_study_screen.dart';
// import 'package:FatCat/views/screens/test_screen.dart';
// // Import other screen files as needed

// class AppRouter {
//   static const String home = '/';
//   static const String intermittentStudy = '/intermittent-study';
//   static const String selfStudy = '/self-study';
//   static const String reviewStudy = '/review-study';
//   static const String test = '/test';
//   // Add other route names as needed

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case home:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case intermittentStudy:
//         final cards = settings.arguments as List<CardModel>;
//         return MaterialPageRoute(
//             builder: (_) => IntermittentStudyScreen(cards: cards));
//       case selfStudy:
//         final cards = settings.arguments as List<CardModel>;
//         return MaterialPageRoute(builder: (_) => SelfStudyScreen(cards: cards));
//       case reviewStudy:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//           builder: (_) => ReviewStudyScreen(
//             detailedAnswers: args['detailedAnswers'],
//             correctAnswers: args['correctAnswers'],
//             incorrectAnswers: args['incorrectAnswers'],
//           ),
//         );
//       case test:
//         return MaterialPageRoute(builder: (_) => TestScreen());
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }
