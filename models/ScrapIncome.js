const { DataTypes } = require('sequelize')
const { db1, db2 } = require('../config/database')
const { Income1, Income2 } = require('./Income')

const defineScrapIncome = (sequelizeInstance, IncomeModel) => {
  if (!sequelizeInstance) {
    throw new Error('Sequelize instance is undefined!')
  }

  const ScrapIncome = sequelizeInstance.define('ScrapIncome', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    incomeId: {
      type: DataTypes.INTEGER,
      references: {
        model: IncomeModel,
        key: 'id'
      }
    },
    narration: {
      type: DataTypes.STRING,
      allowNull: true
    },
    buyerName: {
      type: DataTypes.STRING,
      allowNull: true
    },
    bankName: {
      type: DataTypes.STRING,
      allowNull: true
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

  return ScrapIncome
}

// Create ScrapIncome instances for both databases
const ScrapIncome1 = defineScrapIncome(db1, Income1)
const ScrapIncome2 = defineScrapIncome(db2, Income2)

module.exports = { ScrapIncome1, ScrapIncome2 }
