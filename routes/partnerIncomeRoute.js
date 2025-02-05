const express = require("express");
const router = express.Router();

const {
  createPartnerIncome,
  getAllPartnerIncomes,
} = require("../controllers/PartnerIncome");

router.post("/store-partner-income", createPartnerIncome);
router.get("/get-partner-income", getAllPartnerIncomes);

module.exports = router;
