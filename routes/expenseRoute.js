const express = require("express");
const {
  createExpense,
  createExpenseHead,
  getExpenseHead,
  getAllExpenses,
  deleteExpenseDetail,
  getExpenseById,
  updateExpenseDetail,
} = require("../controllers/ExpenseController");
const router = express.Router();

router.post("/store-expense", createExpense);
router.get("/get-expense", getAllExpenses);
router.delete("/delete-expense/:id", deleteExpenseDetail);
router.get("/get-expense-by-id/:id", getExpenseById);
router.post("/update-expense/:id", updateExpenseDetail);

router.post("/store-expense-head", createExpenseHead);
router.get("/get-expense-head", getExpenseHead);

module.exports = router;
