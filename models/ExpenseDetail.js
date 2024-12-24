const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const { ExpenseHead } = require(".");

const ExpenseDetail = sequelize.define("ExpenseDetail", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  ExpenseMasterId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  projectId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  ExpenseHeadId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  naration: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  amount: {
    type: DataTypes.INTEGER,
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

module.exports = ExpenseDetail;
