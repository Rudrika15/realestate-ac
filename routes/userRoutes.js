const express = require("express");
const router = express.Router();
const { User, Role } = require("../models");
const {
  getUser,
  storeUser,
  login,
  getUserById,
  updateUser,
  deleteUser,
  rolesWisePermissions,
} = require("../controllers/UserController");
const authMiddleware = require("../middlewares/authMiddelware");
const authenticateToken = require("../middlewares/authenticateToken");

router.get("/get-users", getUser);
router.get(
  "/roles-wise-permissions",
  authMiddleware,
  authenticateToken,
  rolesWisePermissions
);
router.get("/get-users-by-id/:id", getUserById);
router.post("/update-users/:id", updateUser);
router.delete("/delete-users/:id", deleteUser);
router.post("/add-user", storeUser);

router.post("/login", login);

module.exports = router;
