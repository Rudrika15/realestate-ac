const express = require("express");
const router = express.Router();

const {
  getPermissions,
  getPermissionById,
  updatePermission,
  storePermission,
  deletePermission,
} = require("../controllers/PermissionController");

router.get("/get-permission", getPermissions);
router.get("/get-permission-by-id/:id", getPermissionById);
router.post("/update-permission/:id", updatePermission);
router.post("/store-permission", storePermission);
router.delete("/delete-permission/:id", deletePermission);

module.exports = router;
