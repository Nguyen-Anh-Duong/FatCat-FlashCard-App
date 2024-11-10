// src/models/index.js
const User = require("./user.model");
const Deck = require("./deck.model");
const Card = require("./card.model");
const Image = require("./image.model");
const Class = require("./class.model");
const ClassMember = require("./classmember.model");
const ClassDeck = require("./classdeck.model");
const Category = require("./category.model");
// User-Deck
User.hasMany(Deck, { foreignKey: "user_id", onDelete: "CASCADE" });
Deck.belongsTo(User, { foreignKey: "user_id" });

//also User-Deck , but for issuer
User.hasMany(Deck, { foreignKey: "user_id", onDelete: "CASCADE" });
Deck.belongsTo(User, { foreignKey: "issuer_id" });

// User-Card
// User.hasMany(Card, { foreignKey: 'user_id', onDelete: 'CASCADE' });
// Card.belongsTo(User, { foreignKey: 'user_id' });

// Deck-Card
Deck.hasMany(Card, { foreignKey: "deck_id", onDelete: "CASCADE" });
Card.belongsTo(Deck, { foreignKey: "deck_id" });

// Deck-Category
Deck.belongsTo(Category, { foreignKey: "category_id" });
Category.hasMany(Deck, { foreignKey: "category_id", onDelete: "CASCADE" });

// User-Class
User.hasMany(Class, { foreignKey: "host_user_id", onDelete: "CASCADE" });
Class.belongsTo(User, { foreignKey: "host_user_id" });

// Class-ClassMember
Class.hasMany(ClassMember, { foreignKey: "group_id", onDelete: "CASCADE" });
ClassMember.belongsTo(Class, { foreignKey: "group_id" });

// User-ClassMember
User.hasMany(ClassMember, { foreignKey: "user_id", onDelete: "CASCADE" });
ClassMember.belongsTo(User, { foreignKey: "user_id" });

// Class-ClassDeck
Class.hasMany(ClassDeck, { foreignKey: "group_id", onDelete: "CASCADE" });
ClassDeck.belongsTo(Class, { foreignKey: "group_id" });

// Deck-ClassDeck
Deck.hasMany(ClassDeck, { foreignKey: "deck_id", onDelete: "CASCADE" });
ClassDeck.belongsTo(Deck, { foreignKey: "deck_id" });

module.exports = {
  User,
  Deck,
  Card,
  Image,
  Class,
  ClassMember,
  ClassDeck,
  Category,
};
