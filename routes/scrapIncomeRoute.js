const express = require("express");
const {
  createScrapIncome,
  getAllScrapIncomes,
  createIncomeHead,
  getIncomeHead,
  addIncome,
} = require("../controllers/ScrapIncomeController");
const router = express.Router();

router.get("/get-income-head", getIncomeHead);
router.post("/store-income-head", createIncomeHead);

router.post("/store-scrap-income", createScrapIncome);
router.get("/get-scrap-income", getAllScrapIncomes);

router.post("/store-installments", addIncome);

module.exports = router;
