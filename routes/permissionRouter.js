const express = require("express");
const router = express.Router();

const {
  getPermissions,
  getPermissionById,
  updatePermission,
} = require("../controllers/PermissionController");

router.get("/get-permission", getPermissions);
router.get("/get-permission-by-id/:id", getPermissionById);
router.post("/update-permission/:id", updatePermission);

module.exports = router;
