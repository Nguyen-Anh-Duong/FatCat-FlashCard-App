//access controller
const { SuccessResponse } = require("../core/success.response");
const AccessService = require("../services/access.service");

class AccessController {
  register = async (req, res, next) => {
    return new SuccessResponse({
      message: "Registration successful.",
      metadata: await AccessService.register(req.body),
    }).send(res);
  };

  verifyAccount = async (req, res, next) => {
    const { email, otpCode } = req.body;
    return new SuccessResponse({
      message: "Account verification completed successfully.",
      metadata: await AccessService.verifyAccount({ email, otpCode }),
    }).send(res);
  };

  resendCode = async (req, res, next) => {
    const { email } = req.body;
    return new SuccessResponse({
      message: "Verification code resent. Please check your email.",
      metadata: await AccessService.resendCode({ email }),
    }).send(res);
  };

  login = async (req, res, next) => {
    return new SuccessResponse({
      message: "Welcome back! Login successful.",
      metadata: await AccessService.login(req.body),
    }).send(res);
  };

  logout = async (req, res, next) => {
    const { userId } = req.user;
    const accessToken = req.accessToken;
    return new SuccessResponse({
      message: "Logout successful. See you again soon.",
      metadata: await AccessService.logout({ userId, accessToken }),
    }).send(res);
  };

  logoutAllDevice = async (req, res, next) => {
    const { userId } = req.user;
    return new SuccessResponse({
      message: "Successfully logged out all device.",
      metadata: await AccessService.logoutAllDevice({ userId }),
    }).send(res);
  };

  resetPassword = async (req, res, next) => {
    const { email } = req.body;
    return new SuccessResponse({
      message: "A new password send to your email. Check your email.",
      metadata: await AccessService.resetPassword({ email }),
    }).send(res);
  };

  changePassword = async (req, res, next) => {
    const { userId } = req.user;
    const accessToken = req.accessToken;
    const { oldPassword, newPassword } = req.body;
    return new SuccessResponse({
      message: "Your password has been updated successfully.",
      metadata: await AccessService.changePassword({
        userId,
        oldPassword,
        newPassword,
        accessToken,
      }),
    }).send(res);
  };
}
module.exports = new AccessController();
