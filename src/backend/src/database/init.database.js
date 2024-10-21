const { Sequelize } = require("sequelize");
const  databaseConfig  = require("../config/database.config");

const sequelize = new Sequelize(databaseConfig.development);

try {
    sequelize.authenticate();
    console.log("Connection has been established successfully.");
} catch (error) {
    console.error("Unable to connect to the database:", error);
}
sequelize.sync({force: true}).then(() => {
    console.log("All models were synchronized successfully.");
}).catch((error) => {
    console.error("Error synchronizing models:", error);
});

module.exports = {
    sequelize,
};

