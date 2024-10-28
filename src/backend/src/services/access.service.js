"use strict";

const User = require("../models/user.model");
const bcrypt = require("bcrypt");
const TokenService = require("./token.service");
const { BadRequestError } = require("../core/error.response");
const {pick} = require("../utils");

class AccessService {
    static async signUp({ name, email, password }) {
        if (!name || !email || !password) {
            throw new BadRequestError("Missing required fields");
        }
            const foundUser = await User.findOne({ where: { email } });
        if(foundUser) {
            throw new BadRequestError("User already exists");
        }
        const passwordHash = await bcrypt.hash(password, 10);
        console.log("1111");
        const user = await User.create({name, email, password: passwordHash});
        console.log(user);
        const payload = {
            id: user.id,
            name: user.name,
            email: user.email,
            role: user.role_system,
        };
 
        const refreshToken = await TokenService.generateRefreshToken(payload);
        const accessToken = await TokenService.generateAccessToken(payload);
        
      
        return {
            ...pick({object: user, keys: ["id", "name", "email", "role_system"]}),
            refreshToken,
            accessToken,
        };
    }

    static async signIn({email, password}) {
        const foundUser = await User.findOne({ where: { email } });
        if(!foundUser) {
            throw new BadRequestError("User not found");
        }
        const isMatch = await bcrypt.compare(password, foundUser.password);
        if(!isMatch) {
            throw new BadRequestError("Invalid password");
        }
        const payload = {
            id: foundUser.id,
            name: foundUser.name,
            email: foundUser.email,
            role: foundUser.role_system,
        };
        const refreshToken = await TokenService.generateRefreshToken(payload);
        const accessToken = await TokenService.generateAccessToken(payload);
        return {
            ...pick({object: foundUser, keys: ["id", "name", "email", "role_system"]}),
            refreshToken,
            accessToken,
        };
    }
    static async logout(refreshToken) {
        
        return {
           code: 200,
        }
    }
}
module.exports = AccessService;
