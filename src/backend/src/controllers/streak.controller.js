const { SuccessResponse } = require("../core/success.response");
const updateStreakService = require("../services/streak.service");
const expressAsyncHandler = require("express-async-handler");

const updateStreakController = expressAsyncHandler(async function (
  req,
  res,
  next
) {
  const { userId } = req.user;
  return new SuccessResponse({
    message: "Update streak successfully",
    metadata: await updateStreakService({ userId }),
  }).send(res);
});

module.exports = updateStreakController;
