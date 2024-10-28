const { DataTypes } = require("sequelize");
const { sequelize } = require("../database/init.database");
const User = require("./user.model");
const Class = require("./class.model");

const ClassMember = sequelize.define("ClassMember", {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    user_id: {
        type: DataTypes.INTEGER,
        references: {
            model: User,
            key: 'id',
        },
    },
    group_id: {
        type: DataTypes.INTEGER,
        references: {
            model: Class,
            key: 'id',
        },
    },
    joined_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
    },
}, {
    tableName: "ClassMembers",
    timestamps: false,
});

module.exports = ClassMember;