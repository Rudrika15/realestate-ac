const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Permission = sequelize.define("Permission", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  permissionName: {
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
  createBy:{
    type: DataTypes.INTEGER,
    allowNull: false
  },
  updateBy:{
    type: DataTypes.INTEGER,
    allowNull: false
  }
});

module.exports = Permission;
