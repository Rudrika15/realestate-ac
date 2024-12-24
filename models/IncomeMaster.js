const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const IncomeMaster = sequelize.define("IncomeMaster", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  incomeDate: {
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
  createBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  updateBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
});

module.exports = IncomeMaster;