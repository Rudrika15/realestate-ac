const express = require("express");
const router = express.Router();

const {
  createPartnerIncome,
  getAllPartnerIncomes,
  deletePartnerIncome,
  getPartnerIncomeDetail,
  updatePartnerIncome,
} = require("../controllers/PartnerIncome");

router.post("/store-partner-income", createPartnerIncome);
router.get("/get-partner-income", getAllPartnerIncomes);
router.delete("/delete-partner-income/:id", deletePartnerIncome);
router.get("/get-single-partner-income/:id", getPartnerIncomeDetail);
router.post("/update-partner-income/:id", updatePartnerIncome);

module.exports = router;
