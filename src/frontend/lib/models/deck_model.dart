class DeckModel {
  String id;
  String name;
  String description;
  bool is_published;
  String deck_cards_count;
  DateTime createdAt;
  DateTime updatedAt;

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
      'is_published': is_published.toString(),
      'deck_cards_count': deck_cards_count,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Deck{id: $id, name: $name, description: $description, is_published: $is_published, deck_cards_count: $deck_cards_count, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

}
