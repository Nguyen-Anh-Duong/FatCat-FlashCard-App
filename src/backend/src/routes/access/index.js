"use strict";

const express = require("express");
const router = express.Router();
const asyncHandler = require("express-async-handler");
const AccessController = require("../../controllers/access.controller");
const accessMiddleware = require("../../middlewares/access.middleware");
router.post("/login", (req, res) => {
    res.status(200).json({
        message: "Login successful",
    });
});

router.post("/signup", asyncHandler(AccessController.signUp));
router.post("/signin", asyncHandler(AccessController.signIn));

// Authentication
router.use(accessMiddleware);

// Authorization
router.post("/logout", asyncHandler(AccessController.logout));
module.exports = router;