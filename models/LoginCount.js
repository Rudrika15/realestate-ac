const { DataTypes } = require('sequelize')
const { db1 } = require('../config/database')

const LoginCount = db1.define('LoginCount', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  loginCount: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  date: {
    type: DataTypes.DATE
  }
})

module.exports = { LoginCount }
