//access controller
const AccessService = require("../services/access.service");

class AccessController {
    signUp = async (req, res, next) => {
        const { name, email, password } = req.body;
        const user = await AccessService.signUp({ name, email, password });
        res.status(200).json(user);
    }
}
module.exports = new AccessController();
