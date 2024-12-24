const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Partner = sequelize.define("Partner", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  partnerName: {
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

module.exports = Partner;
