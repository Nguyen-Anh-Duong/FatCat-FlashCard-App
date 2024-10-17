module.exports = {
    host: process.env.DB_HOST || "localhost",
    dialect: process.env.DB_DIALECT || "mysql",
    database: process.env.DB_NAME || "fatcat",
    username: process.env.DB_USERNAME || "root",
    password: process.env.DB_PASSWORD || "passroot",
    define: {
        timestamps: true,
        underscored: true,
    },
}