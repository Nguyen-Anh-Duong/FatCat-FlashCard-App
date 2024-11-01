"use strict";

const { SuccessResponse } = require("../core/success.response");
const CardService = require("../services/card.service");

class CardController {
    static async getCardsByDeckId(req, res, next) {
        new SuccessResponse({
            message: "Get cards by deck id successfully",
            metadata: await CardService.getCardsByDeckId({...req.query})
        }).send(res);
    }
}

module.exports = CardController;
