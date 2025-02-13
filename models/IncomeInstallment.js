const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const Income = require("./Income");
const Booking = require("./BookingMaster");

const InstallmentIncome = sequelize.define("InstallmentIncome", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  incomeId: {
    type: DataTypes.INTEGER,
    references: {
      model: Income,
      key: "id",
    },
  },
  bookingId: {
    type: DataTypes.INTEGER,
    references: {
      model: Booking,
      key: "id",
    },
  },
  installmentId: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  loanId: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },

  receiptNo: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  receiptName: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  bankName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  chequeNumber: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  chequeDate: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  verificationStatus: {
    type: DataTypes.STRING,
    defaultValue: "Pending",
  },
  verificationDate: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  verificationBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  receiptURL: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  isDeleted: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  isLocked: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  createdBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  updatedBy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
});

Income.hasOne(InstallmentIncome, { foreignKey: "incomeId" });
InstallmentIncome.belongsTo(Income, { foreignKey: "incomeId" });

module.exports = InstallmentIncome;
