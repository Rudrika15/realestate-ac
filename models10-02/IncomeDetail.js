const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const IncomeDetail = sequelize.define("IncomeDetail", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  incomeMasterId: {
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
  incomeHeadId: {
    type: DataTypes.INTEGER,
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
  createdBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
});

module.exports = IncomeDetail;
