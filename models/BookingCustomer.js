const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const BookingCustomer = sequelize.define("BookingCustomer", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  bookingId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  customerId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  isDeleted: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  isLocked: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  createBy: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  updateBy: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
});

module.exports = BookingCustomer;