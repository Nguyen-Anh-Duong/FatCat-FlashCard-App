const User = require("../models/user.model");
const ApiError = require("../utils/ApiError");
const moment = require("moment");

const updateStreak = async ({ userId }) => {
  const foundUser = await User.findByPk(userId);
  if (!foundUser) throw new ApiError("Khong tim thay user.", 404);

  const today = moment().startOf("day");
  const lastLoginDate = moment(foundUser.streak_end_at).startOf("day");

  if (lastLoginDate.isSame(today.subtract(1, "days"))) {
    foundUser.streak_length += 1;
    foundUser.streak_end_at = today;
  } else if (!lastLoginDate.isSame(today)) {
    foundUser.streak_length = 1;
    foundUser.streak_end_at = today;
    foundUser.streak_start_at = today;
  }
  // nếu là hôm nay thì ko update gì

  await foundUser.save();

  return foundUser;
};

module.exports = updateStreak;
