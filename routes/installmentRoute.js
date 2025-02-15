const express = require("express");
const router = express.Router();
const { createInstallment, getInstallments } = require("../controllers/InstallmentController");

router.post("/store-installment", createInstallment);
router.get("/get-installment", getInstallments);

module.exports = router;
