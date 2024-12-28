class CardEditModel {
  String deckId;
  String question;
  String answer;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;

  CardEditModel({
    this.deckId = '',
    this.question = '',
    this.answer = '',
    this.id = '',
    this.createdAt,
    this.updatedAt,
  });
}
