class DeckModel {
  final String id;
  final String name;
  final String description;
  final bool is_published;
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
    final deck = DeckModel(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      is_published: json['is_published'],
      deck_cards_count: json['deck_cards_count'].toString(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
    print("==========${deck.toString()}");
    return deck;
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
