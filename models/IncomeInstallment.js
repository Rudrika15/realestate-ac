const { DataTypes } = require('sequelize')
const { db1, db2 } = require('../config/database')
const { Income1, Income2 } = require('./Income')
const { Booking } = require('./BookingMaster')

const defineInstallmentIncome = sequelizeInstance => {
  if (!sequelizeInstance) {
    throw new Error('Sequelize instance is undefined!')
  }

  return sequelizeInstance.define('InstallmentIncome', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    incomeId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: null, // Relationships will be set later
        key: 'id'
      }
    },
    bookingId: {
      type: DataTypes.INTEGER,
      allowNull: false,
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
    receivedFrom: {
      type: DataTypes.STRING,
      allowNull: true
    },
    verificationStatus: {
      type: DataTypes.STRING,
      defaultValue: 'Pending'
    },
    verificationDate: {
      type: DataTypes.DATE,
      allowNull: true
    },
    verificationBy: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    receiptURL: {
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
    },
    updatedBy: {
      type: DataTypes.INTEGER,
      allowNull: true
    }
  })
}

// Initialize models
const InstallmentIncome = defineInstallmentIncome(db1)
const InstallmentIncome2 = defineInstallmentIncome(db2)

// **Set Relationships After Initialization**
if (Income1) {
  Income1.hasOne(InstallmentIncome, { foreignKey: 'incomeId' })
  InstallmentIncome.belongsTo(Income1, { foreignKey: 'incomeId' })
}

if (Income2) {
  Income2.hasOne(InstallmentIncome2, { foreignKey: 'incomeId' })
  InstallmentIncome2.belongsTo(Income2, { foreignKey: 'incomeId' })
}

module.exports = { InstallmentIncome, InstallmentIncome2 }
