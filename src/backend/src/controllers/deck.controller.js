"use strict";

const { SuccessResponse } = require("../core/success.response");
const DeckService = require("../services/deck.service");

class DeckController {
  async getDecksByCategoryName(req, res, next) {
    new SuccessResponse({
      message: "Get decks by category name successfully",
      metadata: await DeckService.getDecksByCategoryName(
        req.query.categoryName
      ),
    }).send(res);
  }

  async createDeck(req, res, next) {
    const { deck, cards } = req.body;
    return new SuccessResponse({
      message: "Create new deck successfully.",
      metadata: await DeckService.createDeck({
        deck,
        cards,
        user_id: req.user.userId,
      }),
    }).send(res);
  }

  async createDeckByCopy(req, res, next) {
    const { deckId } = req.params;
    const { userId } = req.user;
    return new SuccessResponse({
      message: "Copy deck successfully.",
      metadata: await DeckService.createDeckByCopy({ deckId, userId }),
    }).send(res);
  }

  async updateDeck(req, res, next) {
    const { deck } = req.body;
    const deck_id = req.params.deckId;
    const user_id = req.user.userId;
    return new SuccessResponse({
      message: "Update deck successfully.",
      metadata: await DeckService.updateDeck({
        deck,
        deck_id,
        user_id,
      }),
    }).send(res);
  }

  async deleteDeck(req, res, next) {
    const deckId = req.params.deckId;
    const { userId } = req.user;
    return new SuccessResponse({
      message: "Delete deck successfully.",
      metadata: await DeckService.deleteDeck({
        deckId,
        userId,
      }),
    }).send(res);
  }
  async getAllDecks(req, res, next) {
    return new SuccessResponse({
      message: "Get all decks successfully.",
      metadata: await DeckService.getAllDecks(),
    }).send(res);
  }

  async getDeckByUserId(req, res, next) {
    const viewer_id = req.user.userId;
    const author_id = req.params.userId;
    return new SuccessResponse({
      message: "Get all deck by userid successfully",
      metadata: await DeckService.getDeckByUserId({ viewer_id, author_id }),
    }).send(res);
  }

  async getDeckByDeckId(req, res, next) {
    const viewer_id = req.user.userId;
    const deck_id = req.params.deckId;
    return new SuccessResponse({
      message: "Get deck by deck id successfully.",
      metadata: await DeckService.getDeckByDeckId({ viewer_id, deck_id }),
    }).send(res);
  }
}

module.exports = new DeckController();
