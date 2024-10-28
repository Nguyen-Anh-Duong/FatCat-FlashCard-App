"use strict";

const jwt = require("jsonwebtoken");
const { pick } = require("../utils");

class TokenService {
    static async generateRefreshToken(payload) {
        return jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: "30d" });
    }
    
    static async generateAccessToken(payload) {
        return jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: "1m" });
    }

    static async verifyRefreshToken(token) {
        return jwt.verify(token, process.env.JWT_SECRET);
    }
    static async verifyAccessToken(token) {
        return jwt.verify(token, process.env.JWT_SECRET);
    }
    static async refreshAccessToken(refreshToken) {
        const decoded = await this.verifyRefreshToken(refreshToken);
        if(!decoded) {
            throw new ForbiddenError("Unauthorized");
        }
        const payload = pick({object: decoded, keys: ["id", "email", "role_system"]});
        const accessToken = await this.generateAccessToken(payload);
        return accessToken;
    }
}

module.exports = TokenService;