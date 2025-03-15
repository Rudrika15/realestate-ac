const { DataTypes } = require('sequelize')
const { db1, db2 } = require('../config/database')

const defineIncome = sequelizeInstance => {
  if (!sequelizeInstance) {
    throw new Error('Sequelize instance is undefined!')
  }

  const Income = sequelizeInstance.define('Income', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    projectId: {
      type: DataTypes.INTEGER,
      allowNull: true // Project association will be defined later
    },
    incomeType: {
      type: DataTypes.ENUM('installment', 'partner', 'scrap'),
      allowNull: false
    },
    amount: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    },
    paymentMode: {
      type: DataTypes.ENUM('cash', 'cheque'),
      allowNull: false
    },
    incomeHeadId: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    dateReceived: {
      type: DataTypes.DATE,
      allowNull: false
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

  return Income
}

const Income1 = defineIncome(db1)
const Income2 = defineIncome(db2)

module.exports = { Income1, Income2 }
