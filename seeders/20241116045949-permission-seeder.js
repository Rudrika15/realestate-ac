"use strict";

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert("Permissions", [
      {
        permissionName: "User-create",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        permissionName: "User-view",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        permissionName: "User-update",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        permissionName: "User-delete",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete("Permissions", null, {});
  },
};
