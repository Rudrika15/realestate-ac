const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const ProjectStageTransaction = sequelize.define("ProjectStageTransaction", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  projectStageId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  status: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  projectcompletionDate: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  actualCompletionDate: {
    type: DataTypes.DATE,
    allowNull: true,
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

module.exports = ProjectStageTransaction;
