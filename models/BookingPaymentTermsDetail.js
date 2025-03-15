const { DataTypes } = require('sequelize')
const { db1 } = require('../config/database')
const { BookingPaymentTerms } = require('.')

const BookingPaymentTermsDetail = db1.define('BookingPaymentTermsDetail', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  BookingPaymentTermsId: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  type: {
    type: DataTypes.STRING,
    allowNull: false
  },
  installmentAmount: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  installmentDueDate: {
    type: DataTypes.DATE,
    allowNull: false
  },
  stagId: {
    type: DataTypes.INTEGER,
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
    allowNull: false
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: false
  }
})

module.exports = { BookingPaymentTermsDetail }
