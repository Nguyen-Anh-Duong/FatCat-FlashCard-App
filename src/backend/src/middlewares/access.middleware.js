"use strict";

const TokenService = require("../services/token.service");
const { ForbiddenError } = require("../core/error.response");
const HEADER = {
    API_KEY: "x-api-key",
    AUTHORIZATION: "authorization",
    REFRESHTOKEN: "x-rtoken-id",
};

const accessMiddleware = async (req, res, next) => {
    try {
        const refreshToken = req.headers[HEADER?.REFRESHTOKEN];
        const token = req.headers[HEADER?.AUTHORIZATION];

        if (!token) {
            return next(new ForbiddenError("Unauthorized"));
        }

        try {
            const decoded = await TokenService.verifyAccessToken(token);
            req.user = decoded;
            req.refreshToken = refreshToken;
            req.accessToken = token;
            return next();
        } catch (tokenError) {
            if (tokenError.name === 'TokenExpiredError' && refreshToken) {
                try {
                    const newAccessToken = await TokenService.refreshAccessToken(refreshToken);
                    req.accessToken = newAccessToken;
                    req.refreshToken = refreshToken;
                    return next();
                } catch (refreshError) {
                    return next(new ForbiddenError("Invalid refresh token"));
                }
            } else {
                return next(new ForbiddenError("Invalid access token"));
            }
        }
    } catch (error) {
        return next(error);
    }
};

module.exports = accessMiddleware;
