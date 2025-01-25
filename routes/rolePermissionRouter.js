const express = require("express");
const {
  getRolehasPermission,
  storeRoleHasPermission,
} = require("../controllers/RolePermissionController");
const router = express.Router();

router.get("/get-role-permission/:id", getRolehasPermission);
router.post("/store-role-permission", storeRoleHasPermission);

module.exports = router;
