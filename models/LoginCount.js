const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const LoginCount = sequelize.define("LoginCount", {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    userId: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    loginCount: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    date: {
        type: DataTypes.DATE,
    }
});

module.exports = LoginCount;