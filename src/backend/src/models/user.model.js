const { DataTypes } = require("sequelize");
const { sequelize } = require("../database/init.database");

const User = sequelize.define("User", {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
    },
    email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
    },
    password: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    role_system: {
        type: DataTypes.ENUM('user', 'admin'),
        defaultValue: 'user',
    },
    role_group: {
        type: DataTypes.ENUM('leader', 'member'),
        defaultValue: 'member',
    },
    status: {
        type: DataTypes.ENUM('active', 'inactive'),
        defaultValue: 'active',
    }, 
    streak_length: {
        type: DataTypes.INTEGER,
        defaultValue: 0,
    },
    streak_start_at: {
        type: DataTypes.DATE,
    },
    score: {
        type: DataTypes.INTEGER,
        defaultValue: 0,
    },
    streak_end_at: {
        type: DataTypes.DATE,
    },
    last_reviewed_at: {
        type: DataTypes.DATE,
    },
}, {
    tableName: "Users",
    timestamps: true,
});

module.exports = User;
