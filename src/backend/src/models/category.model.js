// src/models/category.model.js
const { DataTypes } = require("sequelize");
const { sequelize } = require("../database/init.database");

const Category = sequelize.define("Category", {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    name: {
        type: DataTypes.STRING,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        allowNull: false,
    },
}, {
    tableName: "Categories",
    timestamps: true,
    charset: 'utf8mb4',
    collate: 'utf8mb4_unicode_ci'
});

module.exports = Category;