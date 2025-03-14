const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const Role = require("./Role");
const Permission = require("./Permission");

const RolePermission = sequelize.define(
  "RolePermission",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    role: {
      type: DataTypes.INTEGER,
      references: {
        model: Role,
        key: "id",
      },
    },
    permission: {
      type: DataTypes.INTEGER,
      references: {
        model: Permission,
        key: "permission_id",
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
  },
  {
    defaultScope: {
      where: { isDeleted: false },
    },
    scopes: {
      withDeleted: { where: {} },
    },
  }
);

module.exports = RolePermission;
