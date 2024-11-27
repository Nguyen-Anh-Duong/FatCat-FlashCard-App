// lib/models/card_model.dart
import 'package:FatCat/services/date_time_formatter.dart';

class CardModel {
  final String? id;
  final String? userId;
  final String deckId;
  final String question;
  final String? imageId;
  final String answer;
  final DateTime createdAt;
  final DateTime updatedAt;

  CardModel({
    this.id,
    this.userId,
    required this.deckId,
    required this.question,
    this.imageId,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'].toString(),
      userId: json['userId'],
      deckId: json['deckId'].toString(),
      question: json['question'] as String,
      imageId: json['imageId'],
      answer: json['answer'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'userId': userId,
      'deckId': deckId,
      'question': question,
      'imageId': imageId,
      'answer': answer,
      'createdAt': time_formatter(createdAt),
      'updatedAt': time_formatter(updatedAt),
    };
  }

  @override
  String toString() {
    return 'Card{id: $id, userId: $userId, deckId: $deckId, question: $question, imageID: $imageId, answer: $answer, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
