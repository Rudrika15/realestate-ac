const express = require("express");
const router = express.Router();
const {
  createInstallment,
  getInstallments,
  getInstallmentById,
  deleteInstallment,
} = require("../controllers/InstallmentController");

router.post("/store-installment", createInstallment);
router.get("/get-installment", getInstallments);
router.get("/get-installment-by-id/:id", getInstallmentById);
router.delete("/delete-installment/:id", deleteInstallment);
module.exports = router;
