const {DataTypes} = require("sequelize");
const sequelize = require("../config/database");
const Project = require("./Project");

const BookingMaster = sequelize.define("BookingMaster", {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    projectId: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    projectUnitId: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    brokerName:{
        type: DataTypes.STRING,
        allowNull: false,
    },
    bookingDate: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    saleDeedAmount: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    extraWorkAmount: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    otherWorkAmount: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    approvalStatus: {
        type: DataTypes.ENUM("Pending", "Approved", "Rejected"),
        allowNull: false,
        defaultValue: "Pending",
    },
    approvalDate:{
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
      createBy: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      updateBy: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },

});

module.exports = BookingMaster;