require('dotenv').config()
const { Sequelize } = require('sequelize')

// Main Database (DB1)
const db1 = new Sequelize('realestate', 'root', '', {
  host: '127.0.0.1',
  dialect: 'mysql',
  logging: false
})

// Secondary Database (DB2)
const db2 = new Sequelize('realestate2', 'root', '', {
  host: '127.0.0.1',
  dialect: 'mysql',
  logging: false
})

// Function to test both database connections
const testConnections = async () => {
  try {
    await db1.authenticate()
    console.log('✅ DB1 (realestate) connected successfully.')

    await db2.authenticate()
    console.log('✅ DB2 (realestate2) connected successfully.')
  } catch (error) {
    console.error('❌ Database connection error:', error)
  }
}

// Run the test connections
testConnections()

module.exports = { db1, db2 }
