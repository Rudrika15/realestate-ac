const { DataTypes } = require('sequelize')
const { db1, db2 } = require('../config/database') // Ensure the correct import path

console.log('DB1:', db1 ? 'Loaded' : 'Undefined')
console.log('DB2:', db2 ? 'Loaded' : 'Undefined')

const definePartnerIncome = sequelizeInstance => {
  if (!sequelizeInstance) {
    throw new Error('Sequelize instance is undefined!')
  }

  console.log(
    'Initializing PartnerIncome model for DB:',
    sequelizeInstance.config.database
  )

  const PartnerIncome = sequelizeInstance.define('PartnerIncome', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    incomeId: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    partnerId: {
      type: DataTypes.INTEGER,
      allowNull: false
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

  return PartnerIncome
}

// Create instances for both databases
const PartnerIncomeDb1 = definePartnerIncome(db1)
const PartnerIncomeDb2 = definePartnerIncome(db2)

module.exports = { PartnerIncomeDb1, PartnerIncomeDb2 }
