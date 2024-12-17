"use strict";

const express = require("express");
const router = express.Router();
const asyncHandler = require("express-async-handler");
const AccessController = require("../../controllers/access.controller");
const { authenticateToken } = require("../../middlewares/auth.middleware");

router.post("/register", asyncHandler(AccessController.register));
router.post("/verify-account", asyncHandler(AccessController.verifyAccount));
router.post("/resend-code", asyncHandler(AccessController.resendCode));
router.post("/login", asyncHandler(AccessController.login));
router.post(
  "/logout",
  authenticateToken,
  asyncHandler(AccessController.logout)
);
router.post(
  "/logout-all-device",
  authenticateToken,
  asyncHandler(AccessController.logoutAllDevice)
);
router.post("/reset-password", asyncHandler(AccessController.resetPassword));
router.post(
  "/change-password",
  authenticateToken,
  asyncHandler(AccessController.changePassword)
);
module.exports = router;
