// ignore_for_file: non_constant_identifier_names

import 'package:FatCat/services/date_time_formatter.dart';

class DeckModel {
  String? id;
  String name;
  String description;
  bool is_published;
  String deck_cards_count;
  String? user_id;
  String? user_name;
  String? category_id;
  String? category_name;
  String? question_language;
  String? answer_language;
  bool? is_cloned;
  DateTime createdAt;
  DateTime updatedAt;

  DeckModel({
    required this.id,
    required this.name,
    required this.description,
    required this.is_published,
    required this.deck_cards_count,
    this.user_id,
    this.user_name,
    this.category_id,
    this.category_name,
    this.question_language,
    this.answer_language,
    this.is_cloned,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'description': description,
      'is_published': is_published.toString(),
      'deck_cards_count': deck_cards_count,
      'category_name': category_name ?? '',
      'question_language': question_language ?? 'en',
      'answer_language': answer_language ?? 'en',
      'createdAt': time_formatter(createdAt),
      'updatedAt': time_formatter(updatedAt),
      'is_cloned': is_cloned?.toString() ?? 'false',
    };
  }

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    print('===111');

    DeckModel deck = DeckModel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      is_published: json['is_published'] ?? false,
      deck_cards_count: json['deck_cards_count']?.toString() ?? '0',
      user_id: json['user_id']?.toString() ?? '',
      user_name: json['user_name'] ?? '',
      category_id: json['category_id']?.toString() ?? '',
      category_name: json['category_name'] ?? '',
      question_language: json['question_language'] ?? 'en',
      answer_language: json['answer_language'] ?? 'en',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
    print('===');
    print(deck.toString());
    return deck;
  }

  @override
  String toString() {
    return 'Deck{id: $id, name: $name, description: $description, is_published: $is_published, deck_cards_count: $deck_cards_count, user_id: $user_id, category_id: $category_id, question_language: $question_language, answer_language: $answer_language, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
