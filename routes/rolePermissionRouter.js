const express = require("express");
const {
  getRolehasPermission,
  storeRolehasPermission,
} = require("../controllers/RolePermissionController");
const router = express.Router();

router.get("/get-role-permission/:id", getRolehasPermission);
router.post("/store-role-permission", storeRolehasPermission);

module.exports = router;
