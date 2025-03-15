const { DataTypes } = require('sequelize')
const { db1 } = require('../config/database')

const BookingPaymentTerms = db1.define('BookingPaymentTerms', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  bookingId: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  selectPlan: {
    type: DataTypes.ENUM('Full', 'Installment', 'Loan', 'Mixed'),
    allowNull: false,
    defaultValue: 'Installment'
  },
  frequency: {
    type: DataTypes.STRING,
    allowNull: false
  },
  defaultDate: {
    type: DataTypes.DATE,
    allowNull: true
  },
  loanStatus: {
    type: DataTypes.STRING,
    allowNull: true
  },
  loanBankName: {
    type: DataTypes.STRING,
    allowNull: true
  },
  loanAgentName: {
    type: DataTypes.STRING,
    allowNull: true
  },
  isByBuilder: {
    type: DataTypes.BOOLEAN,
    defaultValue: false
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
    allowNull: false
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: false
  }
})

module.exports = { BookingPaymentTerms } // ✅ Export as an object
