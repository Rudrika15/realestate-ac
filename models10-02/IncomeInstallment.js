const { DataTypes } = require('sequelize')
const sequelize = require('../config/database')
const Income = require('./Income')
const Booking = require('./BookingMaster')
const { Income1 } = require("../models/Income");

const InstallmentIncome = sequelize.define('InstallmentIncome', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  incomeId: {
    type: DataTypes.INTEGER,
    references: {
      model: Income,
      key: 'id'
    }
  },
  bookingId: {
    type: DataTypes.INTEGER,
    references: {
      model: Booking,
      key: 'id'
    }
  },
  installmentId: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  loanId: {
    type: DataTypes.INTEGER,
    allowNull: true
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
    allowNull: false
  },
  chequeNumber: {
    type: DataTypes.STRING,
    allowNull: true
  },
  chequeDate: {
    type: DataTypes.DATE,
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
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true
  }
})

Income1.hasOne(InstallmentIncome, { foreignKey: 'incomeId' })
InstallmentIncome.belongsTo(Income1, { foreignKey: 'incomeId' })

module.exports = InstallmentIncome
