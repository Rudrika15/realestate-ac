const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

// Import User and Role models to set proper associations
const User = require("./User");
const Role = require("./Role");

const UserRole = sequelize.define("UserRole", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: User, // Use the actual User model
      key: "id",
    },
  },
  roleId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: Role, // Use the actual Role model
      key: "id",
    },
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
    allowNull: false,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
});

module.exports = UserRole;
