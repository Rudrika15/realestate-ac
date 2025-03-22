const { DataTypes } = require('sequelize')
const sequelize = require('../config/database')
const Role = require('./Role')

const User = sequelize.define('User', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  userName: {
    type: DataTypes.STRING,
    allowNull: false
  },
  status: {
    type: DataTypes.ENUM('Active', 'Inactive'),
    defaultValue: 'Active'
  },
  passcode: {
    type: DataTypes.STRING,
    allowNull: false
  },
  authPasscode: {
    type: DataTypes.STRING,
    allowNull: true
  },
  isDeleted: {
    type: DataTypes.BOOLEAN,
    defaultValue: false
  },
  isLocked: {
    type: DataTypes.BOOLEAN,
    defaultValue: false
  },
  createdBy: {
    type: DataTypes.INTEGER,
    allowNull: true
    // references: {
    //   model: "Users", // Ensure this matches the table name exactly
    //   key: "id",
    // },
    // onDelete: "SET NULL",
    // onUpdate: "CASCADE",
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true
  }
})

module.exports = User
