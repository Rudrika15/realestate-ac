const express = require("express");
const {
  createScrapIncome,
  getAllScrapIncomes,
} = require("../controllers/ScrapIncomeController");
const router = express.Router();

router.post("/store-scrap-income", createScrapIncome);
router.get("/get-scrap-income", getAllScrapIncomes);

module.exports = router;
