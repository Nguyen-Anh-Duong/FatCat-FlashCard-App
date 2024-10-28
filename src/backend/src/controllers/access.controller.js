//access controller
const { SuccessResponse } = require("../core/success.response");
const AccessService = require("../services/access.service");

class AccessController {
    signUp = async (req, res, next) => {
        new SuccessResponse({
            message: "Sign up successfully",
            metadata: await AccessService.signUp(req.body),
        }).send(res);
    }

    signIn = async (req, res, next) => {
        new SuccessResponse({
            message: "Sign in successfully",
            metadata: await AccessService.signIn(req.body),
        }).send(res);
    }

    logout = async (req, res, next) => {
        new SuccessResponse({
            message: "Logout successfully",
            metadata: await AccessService.logout(req.refreshToken),
        }).send(res);
    }
}
module.exports = new AccessController();
