const { DataTypes } = require('sequelize')
const { db1, db2 } = require('../config/database')

const definePartner = sequelizeInstance => {
  if (!sequelizeInstance) {
    throw new Error('Sequelize instance is undefined!')
  }
  const Partner = sequelizeInstance.define('Partner', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    partnerName: {
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
      allowNull: false
    },
    updatedBy: {
      type: DataTypes.INTEGER,
      allowNull: false
    }
  })
}

const Partner = definePartner(db1)
const Partner2 = definePartner(db2)

module.exports = { Partner, Partner2 }
