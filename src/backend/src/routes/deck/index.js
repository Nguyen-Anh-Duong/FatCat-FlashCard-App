"use strict";

const express = require("express");
const router = express.Router();
const asyncHandler = require("express-async-handler");
const DeckController = require("../../controllers/deck.controller");
const { authenticateToken } = require("../../middlewares/auth.middleware");

router.get("/category", asyncHandler(DeckController.getDecksByCategoryName));
router.post("/", authenticateToken, asyncHandler(DeckController.createDeck));
router.put(
  "/:deckId",
  authenticateToken,
  asyncHandler(DeckController.updateDeck)
);
router.delete(
  "/:deckId",
  authenticateToken,
  asyncHandler(DeckController.deleteDeck)
);
router.post(
  "/:deckId/copy",
  authenticateToken,
  asyncHandler(DeckController.createDeckByCopy)
);
router.get("/", asyncHandler(DeckController.getAllDecks));

router.get(
  "/user/:userId",
  authenticateToken,
  asyncHandler(DeckController.getDeckByUserId)
);

router.get(
  "/:deckId",
  authenticateToken,
  asyncHandler(DeckController.getDeckByDeckId)
);
module.exports = router;
