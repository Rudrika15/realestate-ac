const { DataTypes } = require('sequelize')
const { db1, db2 } = require('../config/database')

const defineIncomeMaster = sequelizeInstance => {
  if (!sequelizeInstance) {
    throw new Error('Sequelize instance is undefined!')
  }

  const IncomeMaster = sequelizeInstance.define('IncomeMaster', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    incomeDate: {
      type: DataTypes.DATE,
      allowNull: false
    },
    totalAmount: {
      type: DataTypes.INTEGER,
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

  return IncomeMaster
}

const IncomeMaster = defineIncomeMaster(db1)
const IncomeMaster2 = defineIncomeMaster(db2)
module.exports = { IncomeMaster, IncomeMaster2 }
