const { DataTypes } = require('sequelize')
const sequelize = require('../config/database')

const IncomeBookingDetail = sequelize.define('IncomeBookingDetail', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },

  incomeBookingId: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  term_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  percentage: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  createdBy: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true
  }
})

module.exports = IncomeBookingDetail
