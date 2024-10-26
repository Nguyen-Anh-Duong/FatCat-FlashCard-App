class ProgressModel {
  final String id;
  final String userId;
  final String cardId;
  final DateTime lastReviewedAt;
  final String reviewCount;
  final DateTime nextReviewAt;

  ProgressModel({
    required this.id,
    required this.userId,
    required this.cardId,
    required this.lastReviewedAt,
    required this.reviewCount,
    required this.nextReviewAt,
  });

  Map <String, Object?> toMap() {
    return {
      'id': id,
      'userId': userId,
      'cardId': cardId,
      'lastReviewedAt': lastReviewedAt,
      'reviewCount': reviewCount,
      'nextReviewAt': nextReviewAt,
    };
  }

  @override
  String toString() {
    return 'Progress{id: $id, userId: $userId, cardId: $cardId, lastReviewedAt: $lastReviewedAt, reviewCount: $reviewCount, nextReviewedAt: $nextReviewAt}';
  }
}