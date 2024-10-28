"use strict";
const express = require("express");
const morgan = require("morgan");
const helmet = require("helmet");
const compression = require("compression");
require("dotenv").config();
const {sequelize} = require("./database/init.database")
const {User, Deck, Card, Image, Class, ClassMember, ClassDeck, Category} = require("./models")
const seedLanguageData = require("./utils/seedLanguageData")
const seedUserData = require("./utils/seedUserData")

const app = express();

app.use(morgan("dev"));
app.use(helmet());
app.use(compression());
app.use(express.json());

//init database
sequelize.sync({ force: true}).then(async () => {
    console.log("All models were synchronized successfully.");
    await seedUserData();
    await seedLanguageData();
}).catch((error) => {
    console.error("Error synchronizing models:", error);
});

//init routes
app.use("/", require("./routes"));


//handle errors
app.use((req, res, next) => {
    const error = new Error("Not found");
    error.status = 404;
    next(error);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500);
    res.json({
        status: error.status,
        code: error.code,
        message: error.message || "Internal Server Error",
        stack: error.stack,
    })
})

module.exports = app;
