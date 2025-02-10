const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const ProjectStage = sequelize.define("ProjectStage", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  projectId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  projectStageName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  projectStagePer: {
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
    allowNull: false,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
});

module.exports = ProjectStage;
