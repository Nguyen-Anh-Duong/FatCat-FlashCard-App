"use strict";

const express = require("express");
const router = express.Router();
const asyncHandler = require("express-async-handler");
const DeckController = require("../../controllers/deck.controller");


router.get("/category", asyncHandler(DeckController.getDecksByCategoryName));
module.exports = router;