const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const { BookingPaymentTerms } = require("./index10-02");

const BookingPaymentTermsDetail = sequelize.define(
  "BookingPaymentTermsDetail",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    BookingPaymentTermsId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    type: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    installmentAmount: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    installmentDueDate: {
      type: DataTypes.DATE,
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
  }
);

module.exports = BookingPaymentTermsDetail;
