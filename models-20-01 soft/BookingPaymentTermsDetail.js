const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const { BookingPaymentTerms } = require(".");

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

module.exports = BookingPaymentTermsDetail;
