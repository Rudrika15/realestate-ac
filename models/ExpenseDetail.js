const { DataTypes } = require('sequelize')
const { db1, db2 } = require('../config/database')

const defineExpenseDetail = sequelizeInstance => {
  if (!sequelizeInstance) {
    throw new Error('Sequelize instance is undefined!')
  }

  console.log(
    'Initializing ExpenseDetail model for DB:',
    sequelizeInstance.config.database
  )

  return sequelizeInstance.define(
    'ExpenseDetail',
    {
      id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      expenseMasterId: {
        // ✅ Use camelCase instead of ExpenseMasterId
        type: DataTypes.INTEGER,
        allowNull: false
      },
      projectId: {
        type: DataTypes.INTEGER,
        allowNull: false
      },
      name: {
        type: DataTypes.STRING,
        allowNull: true
      },
      expenseHeadId: {
        // ✅ Use camelCase instead of ExpenseHeadId
        type: DataTypes.INTEGER,
        allowNull: false
      },
      naration: {
        // ✅ Fix the typo (naration → narration)
        type: DataTypes.STRING,
        allowNull: false
      },
      amount: {
        type: DataTypes.STRING,
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
    },
    {
      tableName: 'expensedetails', // ✅ Explicitly define the table name
      timestamps: true
    }
  )
}

// ✅ Now models will be properly assigned
const ExpenseDetail = defineExpenseDetail(db1)
const ExpenseDetail2 = defineExpenseDetail(db2)

module.exports = {
  ExpenseDetail,
  ExpenseDetail2
}
