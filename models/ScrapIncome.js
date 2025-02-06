const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const Income = require("./Income");

const ScrapIncome = sequelize.define("ScrapIncome", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  incomeId: {
    type: DataTypes.INTEGER,
    references: {
      model: Income,
      key: "id",
    },
  },
  incomeHeadId: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  buyerName: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  bankName: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  chequeNumber: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  chequeDate: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  isDeleted: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  isLocked: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  createdBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
});

Income.hasOne(ScrapIncome, { foreignKey: "incomeId" });
ScrapIncome.belongsTo(Income, { foreignKey: "incomeId" });

module.exports = ScrapIncome;
