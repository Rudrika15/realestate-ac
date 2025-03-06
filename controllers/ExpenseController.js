const { ExpenseHead, ExpenseMaster, ExpenseDetail } = require("../models");
const { Op } = require("sequelize"); // Import Sequelize operators

exports.createExpense = async (req, res) => {
  try {
    const userId = req.userId;
    const { voucherNo, expenseDate, amountTotal, expenseDetails } = req.body;

    // Validate required fields
    if (!voucherNo) {
      return res
        .status(400)
        .json({ status: false, message: "voucherNo is required" });
    }
    if (!expenseDate) {
      return res
        .status(400)
        .json({ status: false, message: "expenseDate is required" });
    }
    if (!amountTotal) {
      return res
        .status(400)
        .json({ status: false, message: "amountTotal is required" });
    }
    if (!Array.isArray(expenseDetails) || expenseDetails.length === 0) {
      return res.status(400).json({
        status: false,
        message: "expenseDetails array is required and cannot be empty",
      });
    }

    // Validate and encrypt each expense detail entry
    for (let expense of expenseDetails) {
      if (!expense.projectId) {
        return res.status(400).json({
          status: false,
          message: "Each expenseDetail must have a projectId",
        });
      }
      if (!expense.ExpenseHeadId) {
        return res.status(400).json({
          status: false,
          message: "Each expenseDetail must have an ExpenseHeadId",
        });
      }
      if (!expense.naration || typeof expense.naration !== "string") {
        return res.status(400).json({
          status: false,
          message: "Each expenseDetail must have a valid naration",
        });
      }
      if (
        !expense.amount ||
        isNaN(expense.amount) ||
        parseFloat(expense.amount) <= 0
      ) {
        return res.status(400).json({
          status: false,
          message: "Each expenseDetail must have a valid amount",
        });
      }
    }

    // Encrypt total amount before saving to DB
    const encryptedTotalAmount = encrypt(amountTotal.toString());

    // Create expense master entry
    const expenseMaster = await ExpenseMaster.create({
      voucherNo,
      expenceDate: expenseDate,
      totalAmount: encryptedTotalAmount, // Store encrypted total amount
      createdBy: userId,
      updatedBy: userId,
    });

    const expenseMasterId = expenseMaster.id;

    // Prepare encrypted expense details
    const formattedExpenseDetails = expenseDetails.map((expense) => ({
      ExpenseMasterId: expenseMasterId,
      name: " ",
      projectId: expense.projectId,
      ExpenseHeadId: expense.ExpenseHeadId,
      naration: expense.naration,
      amount: encrypt(expense.amount.toString()),
      createdBy: userId,
      updatedBy: userId,
    }));

    // Save expense details
    await ExpenseDetail.bulkCreate(formattedExpenseDetails);

    return res.status(200).json({
      status: true,
      message: "Expense created successfully",
      data: {
        expenseMaster,
        expenseDetails: formattedExpenseDetails,
      },
    });
  } catch (error) {
    console.error("Error while creating expense:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while creating the expense",
      error: error.message,
    });
  }
};

const { encrypt, decrypt } = require("../utils/cryptoUtils");

exports.getAllExpenses = async (req, res) => {
  try {
    const { projectId, ExpenseHeadId, startDate, endDate } = req.query;

    const expenseMasterWhereCondition = {};
    const expenseDetailWhereCondition = {};

    if (startDate && endDate) {
      expenseMasterWhereCondition.expenceDate = {
        [Op.between]: [new Date(startDate), new Date(endDate)],
      };
    } else if (startDate) {
      expenseMasterWhereCondition.expenceDate = {
        [Op.gte]: new Date(startDate),
      };
    } else if (endDate) {
      expenseMasterWhereCondition.expenceDate = {
        [Op.lte]: new Date(endDate),
      };
    }

    if (projectId) {
      expenseDetailWhereCondition.projectId = projectId;
    }

    if (ExpenseHeadId) {
      expenseDetailWhereCondition.ExpenseHeadId = ExpenseHeadId;
    }

    const expenses = await ExpenseMaster.findAll({
      where: Object.keys(expenseMasterWhereCondition).length
        ? expenseMasterWhereCondition
        : undefined,
      include: [
        {
          model: ExpenseDetail,
          as: "details",
          where: Object.keys(expenseDetailWhereCondition).length
            ? expenseDetailWhereCondition
            : undefined,
          include: [
            {
              model: ExpenseHead,
              as: "expenseHead",
            },
          ],
        },
      ],
    });

    if (!expenses || expenses.length === 0) {
      return res.status(404).json({
        status: false,
        message: "No expenses found",
      });
    }

    // Decrypt amount before returning response
    const formattedExpenses = expenses.map((expense) => ({
      ...expense.toJSON(),
      totalAmount: decrypt(expense.totalAmount), // Decrypt total amount
      details: expense.details.map((detail) => ({
        ...detail.toJSON(),
        amount: decrypt(detail.amount), // Decrypt each amount
      })),
    }));

    return res.status(200).json({
      status: true,
      message: "Expenses retrieved successfully",
      data: formattedExpenses,
    });
  } catch (error) {
    console.error("Error while retrieving expenses:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while retrieving the expenses",
      error: error.message,
    });
  }
};

exports.deleteExpenseDetail = async (req, res) => {
  const { id } = req.params;

  try {
    // Find expense detail
    const expenseDetail = await ExpenseDetail.findOne({ where: { id } });

    if (!expenseDetail) {
      return res.status(404).json({
        status: false,
        message: "Expense detail not found",
        // data: expenseDetail,1111
      });
    }

    const expenseMasterId = expenseDetail.expenseMasterId;

    // Find the associated ExpenseMaster record
    const expenseMaster = await ExpenseMaster.findOne({
      where: { id: expenseMasterId },
    });

    if (!expenseMaster) {
      return res.status(404).json({
        status: false,
        message: "Expense master not found",
      });
    }

    const updatedTotal = expenseMaster.totalAmount - expenseDetail.amount;

    // Delete expense detail first
    await expenseDetail.destroy();

    // Update or delete ExpenseMaster based on the updated total amount
    if (updatedTotal > 0) {
      await ExpenseMaster.update(
        { totalAmount: updatedTotal },
        { where: { id: expenseMasterId } }
      );
    } else {
      await ExpenseMaster.destroy({ where: { id: expenseMasterId } });
    }

    return res.status(200).json({
      status: true,
      message: "Expense detail deleted successfully",
    });
  } catch (error) {
    return res.status(500).json({
      status: false,
      error: error.message,
      message: "An error occurred while deleting the expense detail",
    });
  }
};

exports.getExpenseById = async (req, res) => {
  const id = req.params.id;
  try {
    const expenseDetail = await ExpenseDetail.findOne({ where: { id } });
    if (!expenseDetail) {
      return res.status(200).json({
        status: false,
        message: "Expense detail not found",
      });
    }
    const ExpenseMasterId = expenseDetail.expenseMasterId;
    const expenseMaster = await ExpenseMaster.findOne({
      where: { id: ExpenseMasterId },
    });

    return res.status(200).json({
      status: true,
      message: "Expense detail fetched successfully",
      data: { expenseDetail, expenseMaster },
    });
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: "An error occurred while fetching the expense detail",
    });
  }
};
exports.updateExpenseDetail = async (req, res) => {
  const { id } = req.params;
  const { naration, amount, projectId, expenseHeadId, voucherNo, expenseDate } =
    req.body;

  try {
    if (!naration) {
      return res.status(200).json({
        status: false,
        message: "naration is required",
      });
    }
    if (!amount) {
      return res.status(200).json({
        status: false,
        message: "amount is required",
      });
    }
    if (!projectId) {
      return res.status(200).json({
        status: false,
        message: "projectId is required",
      });
    }
    if (!expenseHeadId) {
      return res.status(200).json({
        status: false,
        message: "expenseHeadId is required",
      });
    }
    if (!voucherNo) {
      return res.status(200).json({
        status: false,
        message: "voucherNo is required",
      });
    }
    if (!expenseDate) {
      return res.status(200).json({
        status: false,
        message: "expenseDate is required",
      });
    }

    const expenseDetail = await ExpenseDetail.findOne({ where: { id } });
    if (!expenseDetail) {
      return res.status(200).json({
        status: false,
        message: "Expense detail not found",
      });
    }

    expenseDetail.naration = naration;
    expenseDetail.amount = amount;
    expenseDetail.projectId = projectId;
    expenseDetail.expenseHeadId = expenseHeadId;
    expenseDetail.updatedBy = req.userId;
    await expenseDetail.save();

    //find expense total form expense detail
    const expenseTotal = await ExpenseDetail.sum("amount", {
      where: { expenseMasterId: expenseDetail.expenseMasterId },
    });
    const expenseMaster = await ExpenseMaster.findOne({
      where: { id: expenseDetail.expenseMasterId },
    });

    expenseMaster.expenceDate = expenseDate;
    expenseMaster.voucherNo = voucherNo;
    expenseMaster.totalAmount = expenseTotal;
    await expenseMaster.save();

    return res.status(200).json({
      status: true,
      message: "Expense detail updated successfully",
      data: expenseDetail,
    });
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message,
      message: "An error occurred while updating the expense detail",
    });
  }
};
exports.createExpenseHead = async (req, res) => {
  const { expenseHeadName } = req.body;
  const userId = req.userId;
  try {
    if (!expenseHeadName) {
      return res.status(200).json({
        status: false,
        message: "expenseHeadName is required",
      });
    }
    const existingExpenseHead = await ExpenseHead.findOne({
      where: { ExpenseHeadName: expenseHeadName },
    });
    if (existingExpenseHead) {
      return res.status(200).json({
        status: false,
        message: "Expense head already exists",
      });
    }
    const expenseHead = await ExpenseHead.create({
      ExpenseHeadName: expenseHeadName,
      createdBy: userId,
      updatedBy: userId,
    });
    return res.status(200).json({
      status: true,
      message: "Expense head created successfully",
      data: expenseHead,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: err.message,
    });
  }
};

exports.getExpenseHead = async (req, res) => {
  try {
    const expenseHead = await ExpenseHead.findAll();
    return res.status(200).json({
      status: true,
      message: "Expense head fetched successfully",
      data: expenseHead,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: err.message,
    });
  }
};
