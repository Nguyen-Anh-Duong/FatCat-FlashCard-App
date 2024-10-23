class DeckModel {
  final String id;
  final String deckId;
  final String name;
  final String description;
  final String is_published;
  final String deck_cards_count;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeckModel({
    required this.id,
    required this.deckId,
    required this.name,
    required this.description,
    required this.is_published,
    required this.deck_cards_count,
    required this.createdAt,
    required this.updatedAt,
  });
}
