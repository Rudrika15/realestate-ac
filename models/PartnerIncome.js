const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const Income = require("./Income");
const Partner = require("./Partner");

const PartnerIncome = sequelize.define("PartnerIncome", {
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
  partnerId: {
    type: DataTypes.INTEGER,
    references: {
      model: Partner,
      key: "id",
    },
  },
  bankName: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  chequeNumber: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  chequeDate: {
    type: DataTypes.DATE,
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

Income.hasOne(PartnerIncome, { foreignKey: "incomeId" });
PartnerIncome.belongsTo(Income, { foreignKey: "incomeId" });

module.exports = PartnerIncome;
