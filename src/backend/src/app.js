"use strict";
const express = require("express");
const morgan = require("morgan");
const helmet = require("helmet");
const compression = require("compression");
require("dotenv").config();

const app = express();

app.use(morgan("dev"));
app.use(helmet());
app.use(compression());
app.use(express.json());

//init database
require("./database/init.database");

//init routes
app.use("/", require("./routes"));

//handle errors
app.use((req, res, next) => {
  const error = new Error("Not found");
  error.status = 404;
  next(error);
});

app.use((error, req, res, next) => {
  console.log(hehe);
  res.status(error.status || 500);
  res.json({
    status: error.status,
    code: error.code,
    message: error.message || "Internal Server Error",
    stack: error.stack,
  });
});

module.exports = app;
