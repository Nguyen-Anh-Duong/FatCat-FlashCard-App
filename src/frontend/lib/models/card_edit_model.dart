class CardEditModel {
  String deckId;
  String question;
  String answer;
  DateTime? createdAt;
  DateTime? updatedAt;

  CardEditModel({
    this.deckId = '',
    this.question = '',
    this.answer = '',
    this.createdAt,
    this.updatedAt,
  });
}
