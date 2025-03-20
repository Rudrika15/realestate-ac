const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const ExpenseMaster = sequelize.define("ExpenseMaster", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  voucherNo: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  expenceDate: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  totalAmount: {
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
  createdBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
});

module.exports = ExpenseMaster;
