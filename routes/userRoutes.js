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
} = require("../controllers/UserController");
const authMiddleware = require("../middlewares/authMiddelware");

router.get("/get-users", getUser);
router.get("/get-users-by-id/:id", getUserById);
router.post("/update-users/:id", updateUser);
router.delete("/delete-users/:id", deleteUser);
router.post("/add-user", storeUser);

router.post("/login", login);

module.exports = router;
