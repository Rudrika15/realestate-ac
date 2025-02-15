const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const Project = require("./Project");
const PartnerIncome = require("./PartnerIncome");
const User = require("./User");

const Income = sequelize.define("Income", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  projectId: {
    type: DataTypes.INTEGER,
    references: {
      model: Project,
      key: "id",
    },
  },
  incomeType: {
    type: DataTypes.ENUM("installment", "partner", "scrap"),
    allowNull: false,
  },
  amount: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
  },
  paymentMode: {
    type: DataTypes.ENUM("cash", "cheque"),
    allowNull: false,
  },

  incomeHeadId: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  dateReceived: {
    type: DataTypes.DATE,
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
  createdBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
});

module.exports = Income;
