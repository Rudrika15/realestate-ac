const express = require("express");
const router = express.Router();
const { createInstallment } = require("../controllers/InstallmentController");

router.post("/store-installment", createInstallment);

module.exports = router;
