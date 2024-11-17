// ignore_for_file: non_constant_identifier_names

import 'package:FatCat/services/date_time_formatter.dart';

class DeckEditModel {
  String name;
  String description;
  String? category_name;
  String? question_language;
  String? answer_language;
  DateTime createdAt;
  DateTime updatedAt;

  DeckEditModel({
    required this.name,
    required this.description,
    this.category_name,
    this.question_language,
    this.answer_language,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'description': description,
      'category_name': category_name ?? '',
      'question_language': question_language ?? 'en',
      'answer_language': answer_language ?? 'en',
      'createdAt': time_formatter(createdAt),
      'updatedAt': time_formatter(updatedAt),
    };
  }

  factory DeckEditModel.fromJson(Map<String, dynamic> json) {
    DeckEditModel deck = DeckEditModel(
      name: json['name'],
      description: json['description'],
      category_name: json['category_name'] ?? '',
      question_language: json['question_language'] ?? 'en',
      answer_language: json['answer_language'] ?? 'en',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
    print(deck.toString());
    return deck;
  }

  @override
  String toString() {
    return 'Deck{name: $name, description: $description, category_name: $category_name, question_language: $question_language, answer_language: $answer_language, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
