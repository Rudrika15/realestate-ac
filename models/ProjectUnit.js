const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const ProjectUnit = sequelize.define("ProjectUnit", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  projectId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  unitType: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  unitNo: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  wing: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  size: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  currerntStatus: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  saleDeedAmount: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  extraWorkAmount: {
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
  createdBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
});

module.exports = ProjectUnit;
