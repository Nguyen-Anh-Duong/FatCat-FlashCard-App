"use strict";

const { SuccessResponse } = require("../core/success.response");
const DeckService = require("../services/deck.service");

class DeckController {
     async getDecksByCategoryName(req, res, next) {
        new SuccessResponse({
            message: "Get decks by category name successfully",
            metadata: await DeckService.getDecksByCategoryName(req.query.categoryName)
        }).send(res);
    }
}

module.exports = new DeckController();
