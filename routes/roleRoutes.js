const express = require("express");
const router = express.Router();

const {
  getRole,
  storeRole,
  getRoleById,
  updateRole,
  deleteRole,
} = require("./../controllers/RoleController");

router.get("/get-role", getRole);
router.get("/get-role/:id", getRoleById);
router.post("/store-role", storeRole);
router.post("/update-role/:id", updateRole);
router.delete("/delete-role/:id", deleteRole);

module.exports = router;
