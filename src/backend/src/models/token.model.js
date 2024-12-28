const { Buffer } = require("node:buffer");
const { DataTypes } = require("sequelize");
const { sequelize } = require("../database/init.database");
const { add } = require("date-fns");
const User = require("./user.model");

const Token = sequelize.define(
  "Token",
  {
    userId: {
      type: DataTypes.INTEGER,
      references: {
        model: User,
        key: "id",
      },
    },
    accessToken: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    expiresAt: {
      type: DataTypes.DATE,
    },
  },
  {
    tableName: "Tokens",
    timestamps: true,
    hooks: {
      beforeCreate: (token) => {
        const encodedAccessToken = token.accessToken; // an access token
        const tokenParts = encodedAccessToken.split(".");

        const decodedPayload = Buffer.from(tokenParts[1], "base64").toString(
          "utf-8"
        );
        const decodedObject = JSON.parse(decodedPayload);

        token.expiresAt = new Date(decodedObject.exp * 1000); // jwt expiration date
      },
    },
  }
);

module.exports = Token;
