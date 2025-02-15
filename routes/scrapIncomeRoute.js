const express = require("express");
const {
  createScrapIncome,
  getAllScrapIncomes,
  createIncomeHead,
  getIncomeHead,
  addIncome,
  getOtherSingleIncome,
  deleteScrapIncome,
  updateScrapIncome,
} = require("../controllers/ScrapIncomeController");
const router = express.Router();

router.get("/get-income-head", getIncomeHead);
router.post("/store-income-head", createIncomeHead);

router.post("/store-scrap-income", createScrapIncome);
router.get("/get-scrap-income", getAllScrapIncomes);

router.post("/store-installments", addIncome);

//edit delete
router.get("/get-scrap-income-by-id/:id", getOtherSingleIncome);
router.delete("/delete-scrap-income/:id", deleteScrapIncome);
router.post("/update-scrap-income/:id", updateScrapIncome);

module.exports = router;
