class DeckModel {
  final String id;
  final String name;
  final String description;
  final String is_published;
  final String deck_cards_count;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeckModel({
    required this.id,
    required this.name,
    required this.description,
    required this.is_published,
    required this.deck_cards_count,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      is_published: json['is_published'],
      deck_cards_count: json['deck_cards_count'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_published': is_published,
      'deck_cards_count': deck_cards_count,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'Deck{id: $id, name: $name, description: $description, is_published: $is_published, deck_cards_count: $deck_cards_count, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
