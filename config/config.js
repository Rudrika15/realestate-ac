require("dotenv").config();

module.exports = {
  development: {
    username: process.env.DB_USER || "naroda",
    password: process.env.DB_PASS || "N@roda123",
    database: process.env.DB_NAME || "realestateDB",
    host: process.env.DB_HOST || "127.0.0.1",
    dialect: process.env.DB_DIALECT || "mysql",
  },
  test: {
    username: process.env.DB_USER || "naroda",
    password: process.env.DB_PASS || "N@roda123",
    database: "realestateDB",
    host: process.env.DB_HOST || "127.0.0.1",
    dialect: process.env.DB_DIALECT || "mysql",
  },
  production: {
    username: process.env.DB_USER || "naroda",
    password: process.env.DB_PASS || "N@roda123",
    database: "realestateDB",
    host: process.env.DB_HOST || "127.0.0.1",
    dialect: process.env.DB_DIALECT || "mysql",
  },
};