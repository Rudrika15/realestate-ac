require("dotenv").config();
const { Sequelize } = require("sequelize");

const sequelize = new Sequelize("realestateDb", "acsw", "N@roda123", {
  host: "127.0.0.1",
  dialect: "mysql",
});
// const sequelize = new Sequelize("realestate", "root", "", {
//   host: "127.0.0.1",
//   dialect: "mysql",
// });

sequelize.authenticate();
// .then(() => console.log('Database connected...'))
// .catch(err => console.log('Error: ' + err));

module.exports = sequelize;
