"use strict";

const { where } = require("sequelize");
const { NotFoundError } = require("../core/error.response");
const { Deck, Category, Card, User } = require("../models");
const ApiError = require("../utils/ApiError");
const { raw } = require("express");
const _ = require("lodash");
const { sequelize } = require("../database/init.database");

class DeckService {
  static async getAllDecks() {
    const decks = await Deck.findAll({
      include: [
        { model: Category, attributes: ["name"] },
        { model: User, attributes: ["name"] },
      ],
    });

    const data = decks.map((deck) => ({
      id: deck.id,
      name: deck.name,
      description: deck.description,
      user_id: deck.user_id,
      user_name: deck.User?.name || "",
      issuer_id: deck.issuer_id,
      category_id: deck.category_id,
      deck_cards_count: deck.deck_cards_count,
      is_published: deck.is_published,
      category_name: deck.Category?.name,
      question_language: deck.question_language,
      answer_language: deck.answer_language,
      created_at: deck.createdAt,
      updated_at: deck.updatedAt,
    }));
    return data;
  }
  static async getDecksByCategoryName(categoryName) {
    const category = await Category.findOne({
      where: { name: categoryName },
    });
    if (!category) {
      throw new NotFoundError("Category not found");
    }
    const decks = await Deck.findAll({
      where: { category_id: category.id },
      include: [{ model: Category, attributes: ["name"] }],
    });
    const data = decks.map((deck) => ({
      id: deck.id,
      name: deck.name,
      description: deck.description,
      user_id: deck.user_id,
      issuer_id: deck.issuer_id,
      category_id: deck.category_id,
      deck_cards_count: deck.deck_cards_count,
      is_published: deck.is_published,
      category_name: deck.Category?.name,
      question_language: deck.question_language,
      answer_language: deck.answer_language,
      created_at: deck.createdAt,
      updated_at: deck.updatedAt,
    }));
    return data;
  }
  //   static async getCardsByDeckId(deckId) {
  //     return await Card.findAll({
  //       where: { deck_id: deckId },
  //     });
  //   }
  //   static async getDeckById(deckId) {
  //     return await Deck.findByPk(deckId);
  //   }
  //   static async createDeck({
  //     user_id,
  //     name,
  //     description,
  //     category_id,
  //     is_published = false,
  //   }) {
  //     return await Deck.create({
  //       user_id,
  //       name,
  //       description,
  //       category_id,
  //       is_published,
  //     });
  //   }
  //   static async updateDeck(
  //     deckId,
  //     { name, description, category_name, is_published }
  //   ) {
  //     const updateFields = {};
  //     if (name) updateFields.name = name;
  //     if (description) updateFields.description = description;
  //     if (category_name) {
  //       const category = await Category.findOne({
  //         where: { name: category_name },
  //       });
  //       if (!category) throw new NotFoundError("Category not found");
  //       updateFields.category_id = category.id;
  //     }
  //     if (is_published !== undefined) updateFields.is_published = is_published;
  //     const updatedDeck = await Deck.update(updateFields, {
  //       where: { id: deckId },
  //     });
  //     if (!updatedDeck) throw new NotFoundError("Deck not found");
  //     return updatedDeck;
  //   }
  //   static async deleteDeck(deckId) {
  //     return await Deck.destroy({ where: { id: deckId } });
  //   }

  //duong lam

  // static getDecks = async ({userId, user}) => {
  //     const canEdit = userId === user.userId ? true : false;
  //     const deck = await Deck.findAll({
  //         where :{
  //             user_id: userId
  //         }
  //     })
  // }
  static getUserInfor = async (userId) => {
    const user = await User.findOne({
      where: {
        id: userId,
      },
    });
    return { username: user.name, avatar: user.avatar };
  };

  static createDeck = async ({ deck, user_id }) => {
    if (!deck) throw new ApiError("Missing deck data.", 400);

    const cards = deck.Cards && deck.Cards.length > 0 ? deck.Cards : [];

    cards.forEach((card) => {
      delete card.id;
    });

    deck.user_id = user_id;

    const insertDeckAndCards = await Deck.create(
      {
        ...deck,
        deck_cards_count: cards.length,
        Cards: cards,
      },
      {
        //attributes: { exclude: ["id", "createdAt", "updatedAt"] },
        include: [Card],
      }
    );

    return { deck: insertDeckAndCards };
  };
  

  // // copy a deck anf all card of that deck for userId. Issuer of new deck is also userId
  // static createDeckByCopy = async ({ deckId, userId }) => {
  //   const queryJoin = await Deck.findAll({
  //     where: {
  //       id: deckId,
  //     },
  //     attributes: { exclude: ["id", "createdAt", "updatedAt"] },
  //     raw: true,

  //     include: [
  //       {
  //         model: Card,
  //         attributes: { exclude: ["id", "createdAt", "updatedAt"] },
  //         //required: true,
  //       },
  //       // {
  //       //   model: User,
  //       //   // where: {
  //       //   //   issuer_id: userId,
  //       //   // },
  //       //   required: true,
  //       //   attributes: { exclude: ["id", "createdAt", "updatedAt"] },
  //       // },
  //     ],
  //   });

  //   if (!queryJoin) throw new ApiError("Deck not found.", 404);
  //   console.log(queryJoin);

  //   const object = queryJoin[0];
  //   //if the user that want copy deck is not the same user create this deck -> check their id, and check deck publish or not at the same time
  //   if (object.issuer_id !== userId && !object.is_published)
  //     throw new ApiError("Access denied.", 403); // if deck.issuer_id === userId  not throw any error

  //   const deckData = {},
  //     cards = [];
  //   let count = 0;

  //   //copy deck
  //   for (const key in object) {
  //     if (count >= 9) break;
  //     deckData[key] = object[key];
  //     count++;
  //   }
  //   deckData.user_id = deckData.issuer_id = userId;

  //   //create deck with same data
  //   const newDeck = await Deck.create(deckData);
  //   const deckDataPlain = newDeck.get({ plain: true });
  //   delete deckDataPlain.createdAt;
  //   delete deckDataPlain.updatedAt;

  //   //copy card
  //   for (let data of queryJoin) {
  //     const card = {};
  //     card.deck_id = newDeck.id;
  //     card.question = data["Cards.question"];
  //     card.image = data["Cards.image"];
  //     card.answer = data["Cards.answer"];
  //     if (card.question && card.answer) cards.push(card);
  //   }

  //   //create cards
  //   let newCards = Array.isArray(cards) ? await Card.bulkCreate(cards) : {};
  //   newCards = newCards.map((card) => {
  //     const { createdAt, updatedAt, ...rest } = card.get({ plain: true });
  //     return rest;
  //   });
  //   return { deckCopy: deckDataPlain, cardsCopy: newCards };
  // };

  // static getDeckByUserId = async ({ viewer_id, author_id }) => {
  //   const deck =
  //     viewer_id == author_id
  //       ? await Deck.findAll({
  //           where: { user_id: viewer_id },
  //           attributes: { exclude: ["createdAt", "updatedAt"] },
  //         })
  //       : await Deck.findAll({
  //           where: {
  //             user_id: author_id,
  //             is_published: true,
  //           },
  //           attributes: { exclude: ["createdAt", "updatedAt"] },
  //         });
  //   return { deck };
  // };

  static getDeckByDeckId = async ({ viewer_id, deck_id }) => {
    const deck = await Deck.findOne({
      where: {
        id: deck_id,
      },
      attributes: { exclude: ["createdAt", "updatedAt"] },
      include: [
        { model: Card, attributes: { exclude: ["createdAt", "updatedAt"] } },
      ],
    });

    if (!deck) throw new ApiError("Deck not found.", 404);

    if (viewer_id != deck.user_id && !deck.is_published)
      throw new ApiError("This deck is private. Access denied.", 403);

    return {
      deck,
    };
  };

  static updateDeck = async ({ deck, deck_id, user_id }) => {
    const optionalFields = [
      "name",
      "description",
      "category_id",
      "is_published",
      "deck_cards_count",
      "question_language",
      "answer_language",
    ];
    if (!deck) throw new ApiError("deck is required in request.", 400);
    //Only the author has the right to edit
    console.log(`userId::${user_id} --- ${deck.user_id}`)
    // if (user_id !== deck.user_id)
    //   throw new ApiError(
    //     "Missing or incorrect value of user_id field in request.",
    //     400
    //   );

    //error if deckId on route is different from deckId in request
    console.log(deck_id + deck)
    if (deck_id != deck.id)
      throw new ApiError("Something went wrong. Try again later.");
    console.log(deck);

    const { Cards, ...deckFields } = deck;

    const existingDeck = await Deck.findByPk(deck_id, {
      //raw: true,
      attributes: { exclude: ["createdAt", "updatedAt"] },
    });
    if (!existingDeck) throw new ApiError("Deck not found.", 404);

    //Check if any field is optional
    const hasFieldsToUpdate = Object.keys(deckFields).some((key) =>
      optionalFields.includes(key)
    );

    const plainExistingDeck = existingDeck.get({ plain: true });

    //update deck only if a field needs to be changed
    if (hasFieldsToUpdate) {
      await existingDeck.update(deckFields);
    }

    await this.syncCards({ deck_id, cards: Cards });
    const newCards = await Card.findAll({
      where: { deck_id },
      attributes: { exclude: ["createdAt", "updatedAt"] },
    });

    //console.log(newCards);

    return {
      deck: {
        ...plainExistingDeck,
        deck_cards_count: newCards.length,
        Cards: newCards,
      },
    };
  };

  static syncCards = async ({ deck_id, cards }) => {
    const existingCards = await Card.findAll({
      where: {
        deck_id,
      },
      attributes: { exclude: ["createdAt", "updatedAt"] },
      raw: true,
    });

    const existingCardIds = existingCards.map((card) => card.id); // nhóm các id của card trong db thành 1 array
    const requestCardIds = cards.map((card) => {
      console.log(`*** ${card.id}`)
      return card.id
    }); // nhóm các id của request thành 1 array

    /* tạo ra 1 object có dạng { create: [], update: [], delete: [] }. 
    Cái card nào không có id thì cho vào mảng create.
     Card nào có id nhưng check thấy thay đổi với card trong db thì cho vào mảng update   */
    const groupCards = cards.reduce(
      (obj, card, index) => {
        console.log(card);
        if (!card.id || card.id.trim() ==='') {
          card.deck_id = deck_id;
     
          delete card.id
          console.log(1)
          obj["create"].push(card);
          return obj;
        } else {
          console.log(2)

          obj["update"].push(card);
          return obj;
        } 
      },
      { create: [], update: [], delete: [] }
    );

    // check xem những card nào có trong db nhưng không có trong request thì card đó bị xóa
    console.log(`exist ${existingCardIds}`);
    console.log(`req ${requestCardIds}`);
    
    const cardIdsToDelete = existingCardIds.filter(
      (id) => {
        console.log(`delete ${id} -- ${!requestCardIds.includes(id)}`);
        return !requestCardIds.includes(id.toString())
      }
    );
    console.log(cardIdsToDelete.length)
    console.log(cardIdsToDelete)
    
    groupCards["delete"].push(...cardIdsToDelete);

    //delete cards
    const bulkDestroy = Card.destroy({
      where: {
        id: groupCards["delete"],
      },
    });

    //create card
    const bulkCreate = Card.bulkCreate(groupCards["create"]);

    //không có câu lệnh bulkUpdate sẵn trong sequelize nên phải dùng raw query
    const statements = [];
    const tableName = "Cards";

    for (let i = 0; i < groupCards["update"].length; i++) {
      statements.push(
        sequelize.query(
          `UPDATE ${tableName} 
          SET question='${groupCards["update"][i].question}' ,
              answer='${groupCards["update"][i].answer}' ,
              image=${
                groupCards["update"][i].image === null
                  ? "NULL"
                  : `'${groupCards["update"][i].image}'`
              }
          WHERE id=${groupCards["update"][i].id};`
        )
      );
    }

    const bulkUpdate = Promise.all(statements);

    await Promise.all([bulkUpdate, bulkCreate, bulkDestroy]);
  };

  static deleteDeck = async ({ deckId, userId }) => {
    const deck = await Deck.findByPk(deckId);
    if (!deck) throw new ApiError("Deck not found.", 404);
    if (userId !== deck.user_id) throw new ApiError("Access denied.", 403);

    //delete deck
    // on cascade, so all card also deleted
    await deck.destroy();
  };
}

module.exports = DeckService;
