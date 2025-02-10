const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Broker = sequelize.define("Broker", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  brokerName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  brokerAddress: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  brokerMobileNumber: {
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
    allowNull: false,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
});

module.exports = Broker;
