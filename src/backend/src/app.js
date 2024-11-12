"use strict";
const express = require("express");
const morgan = require("morgan");
const helmet = require("helmet");
const compression = require("compression");
require("dotenv").config();
const { sequelize } = require("./database/init.database");
const {
  User,
  Deck,
  Card,
  Image,
  Class,
  ClassMember,
  ClassDeck,
  Category,
} = require("./models");
const seedLanguageData = require("./utils/seedLanguageData");
const seedUserData = require("./utils/seedUserData");

const app = express();

app.use(morgan("dev"));
app.use(helmet());
app.use(compression());
app.use(express.json());

//init database

sequelize
  .sync({ alter: true })
  .then(async () => {
    console.log("All models were synchronized successfully.");
    await seedUserData();
    await seedLanguageData();
  })
  .catch((error) => {
    console.error("Error synchronizing models:", error);
  });

sequelize
  .sync()
  .then(() => console.log("Database synchronized"))
  .catch((err) => console.log("Error syncing database:", err));

//init routes
app.use("/", require("./routes"));

//handle errors
app.use((req, res, next) => {
  const error = new Error("Not found");
  error.status = 404;
  next(error);
});

app.use((error, req, res, next) => {
  const statusCode = error.status || 500;
  const errorResponse = {
    status: "error",
    code: statusCode,
    message:
      error.message || "An unexpected error occurred. Please try again later.",
    stack: error.stack,
  };
  if (process.env.ENViRONMENT === "prod") delete errorResponse.stack;
  return res.status(statusCode).json(errorResponse);
});

module.exports = app;
