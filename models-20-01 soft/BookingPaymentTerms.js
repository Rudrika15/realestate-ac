const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const BookingPaymentTerms = sequelize.define(
  "BookingPaymentTerms",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    bookingId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    selectPlan: {
      type: DataTypes.ENUM("Full", "Installment", "Loan", "Mixed"),
      allowNull: false,
      defaultValue: "Installment",
    },
    frequency: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    defaultDate: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    loanStatus: {
      type: DataTypes.ENUM("In Progress", "Completed"),
      allowNull: false,
      defaultValue: "In Progress",
    },
    loanBankName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    loanAgentName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    builderBankName: {
      type: DataTypes.STRING,
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
    createdBy: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    updatedBy: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    defaultScope: {
      where: { isDeleted: false },
    },
    scopes: {
      withDeleted: { where: {} },
    },
  }
);

module.exports = BookingPaymentTerms;
