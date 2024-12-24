const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const CustomerMaster = sequelize.define("CustomerMaster", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  customerName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  type: {
    type: DataTypes.ENUM("Primary", "Others"),
    allowNull: false,
    defaultValue: "Primary",
  },
  address: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  city: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  moblieNumber: {
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
    allowNull: false,
  },
  updateBy: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
});

module.exports = CustomerMaster;
