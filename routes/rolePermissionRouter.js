const express = require("express");
const {
  getRolehasPermission,
} = require("../controllers/RolePermissionController");
const router = express.Router();

router.get("/get-role-permission/:id", getRolehasPermission);
module.exports = router;
