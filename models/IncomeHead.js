const {DataTypes} = require("sequelize");
const sequelize = require("../config/database");

const IncomeHead = sequelize.define("IncomeHead", {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    incomeHeadName: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    isDeleted: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
    },
    isLocked: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
    },
    createBy: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    updateBy: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
});
module.exports = IncomeHead