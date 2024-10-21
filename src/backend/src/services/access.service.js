"use strict";

const { User } = require("../models/user.model");

class AccessService {
    static async signUp({ name, email, password }) {
        const user = await User.create({name, email, password});
        return user;
    }
}
module.exports = AccessService;
