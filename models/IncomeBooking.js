const { DataTypes } = require('sequelize')
const sequelize = require('../config/database')

const IncomeBooking = sequelize.define('IncomeBooking', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },

  bookingId: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  incomeType: {
    type: DataTypes.ENUM('sale_deed', 'extra', 'other'),
    allowNull: false
  },
  incomeDate: {
    type: DataTypes.DATE,
    allowNull: false
  },
  depositDate: {
    type: DataTypes.DATE,
    allowNull: false
  },
  amount: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  receiptNo: {
    type: DataTypes.STRING,
    allowNull: true
  },
  receiptName: {
    type: DataTypes.STRING,
    allowNull: true
  },
  bankName: {
    type: DataTypes.STRING,
    allowNull: true
  },
  chequeNo: {
    type: DataTypes.STRING,
    allowNull: true
  },
  chequeDate: {
    type: DataTypes.DATE,
    allowNull: true
  },
  receiptUrl: {
    type: DataTypes.STRING,
    allowNull: true
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

module.exports = IncomeBooking
