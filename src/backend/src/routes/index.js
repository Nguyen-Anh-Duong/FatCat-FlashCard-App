const express = require("express");

const router = express.Router();

router.get("/v1/api", (req, res) => {
  res.status(200).json({
    message: "Welcome to the API",
  });
});

router.use("/v1/api/deck", require("./deck/index"));
router.use("/v1/api/access", require("./access/index"));
router.use("/v1/api", require("./verify/index"));

module.exports = router;
