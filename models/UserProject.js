const { DataTypes } = require('sequelize')
const { db1 } = require('../config/database')
const { User } = require('./User') // Assuming User model exists
const { Project } = require('./Project') // Assuming Project model exists

const UserProject = db1.define('UserProject', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: User,
      key: 'id'
    },
    onDelete: 'CASCADE'
  },
  projectId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: Project,
      key: 'id'
    },
    onDelete: 'CASCADE'
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

User.belongsToMany(Project, { through: UserProject, foreignKey: 'userId' })
Project.belongsToMany(User, { through: UserProject, foreignKey: 'projectId' })

module.exports = { UserProject }
