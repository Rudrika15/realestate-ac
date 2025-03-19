const { DataTypes } = require("sequelize");
const { db1 } = require("../config/database");

const User = db1.define(
  "User",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    userName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    status: {
      type: DataTypes.ENUM("Active", "Inactive"),
      defaultValue: "Active",
    },
    passcode: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    authPasscode: {
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
      references: {
        model: "User", // Ensure it matches the model name OR use 'users' if explicitly defined
        key: "id",
      },
      onDelete: "SET NULL",
      onUpdate: "CASCADE",
    },
    updatedBy: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
  },
  {
    tableName: "Users", // Explicitly setting the table name
    timestamps: true,
  }
);

// Define associations in an `associate` function to prevent circular dependencies
User.associate = (models) => {
  User.belongsTo(models.User, { foreignKey: "createdBy", as: "creator" });
  User.belongsToMany(models.Role, {
    through: "UserRole",
    foreignKey: "userId",
  });
};

module.exports = { User };
