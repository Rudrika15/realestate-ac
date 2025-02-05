const { ExpenseHead, ExpenseMaster, ExpenseDetail } = require("../models");

// exports.createExpense = async (req, res) => {
//   try {
//     const userId = req.userId;
//     const {
//       voucherNo,
//       expenseDate,
//       amountTotal,
//       projectIds,
//       ExpenseHeadId,
//       naration,
//       amount,
//     } = req.body;

//     // Validate required fields
//     if (!voucherNo) {
//       return res.status(200).json({
//         status: false,
//         message: "voucherNo is required",
//       });
//     }
//     if (!expenseDate) {
//       return res.status(200).json({
//         status: false,
//         message: "expenseDate is required",
//       });
//     }
//     if (!amountTotal) {
//       return res.status(200).json({
//         status: false,
//         message: "amountTotal is required",
//       });
//     }
//     if (!Array.isArray(projectIds) || projectIds.length === 0) {
//       return res.status(200).json({
//         status: false,
//         message: "projectIds array is required and cannot be empty",
//       });
//     }
//     if (!Array.isArray(ExpenseHeadId) || ExpenseHeadId.length === 0) {
//       return res.status(200).json({
//         status: false,
//         message: "ExpenseHeadId array is required and cannot be empty",
//       });
//     }
//     if (!Array.isArray(naration) || naration.length === 0) {
//       return res.status(200).json({
//         status: false,
//         message: "naration array is required and cannot be empty",
//       });
//     }
//     if (!Array.isArray(amount) || amount.length === 0) {
//       return res.status(200).json({
//         status: false,
//         message: "amount array is required and cannot be empty",
//       });
//     }

//     // Ensure all arrays have the same length
//     if (
//       projectIds.length !== ExpenseHeadId.length ||
//       projectIds.length !== naration.length ||
//       projectIds.length !== amount.length
//     ) {
//       return res.status(200).json({
//         status: false,
//         message:
//           "projectIds, ExpenseHeadId, naration, and amount arrays must have the same length",
//       });
//     }

//     // Create expense master entry
//     const expenseMaster = await ExpenseMaster.create({
//       voucherNo,
//       expenceDate: expenseDate,
//       totalAmount: amountTotal,
//       createdBy: userId,
//       updatedBy: userId,
//     });
//     const expenseMasterId = expenseMaster.id;

//     // Prepare expense details
//     const expenseDetails = [];
//     for (let i = 0; i < projectIds.length; i++) {
//       expenseDetails.push({
//         ExpenseMasterId: expenseMasterId,
//         name: " ",
//         projectId: projectIds[i],
//         ExpenseHeadId: ExpenseHeadId[i],
//         naration: naration[i],
//         amount: parseFloat(amount[i]),
//         createdBy: userId,
//         updatedBy: userId,
//       });
//     }

//     // Save expense details
//     await ExpenseDetail.bulkCreate(expenseDetails);

//     return res.status(200).json({
//       status: true,
//       message: "Expense created successfully",
//       data: {
//         expenseMaster,
//         expenseDetails,
//       },
//     });
//   } catch (error) {
//     console.error("Error while creating expense:", error);
//     return res.status(500).json({
//       status: false,
//       message: "An error occurred while creating the expense",
//       error: error.message,
//     });
//   }
// };

exports.createExpense = async (req, res) => {
  try {
    const userId = req.userId;
    const { voucherNo, expenseDate, amountTotal, expenseDetails } = req.body;

    // Validate required fields
    if (!voucherNo) {
      return res.status(400).json({
        status: false,
        message: "voucherNo is required",
      });
    }
    if (!expenseDate) {
      return res.status(400).json({
        status: false,
        message: "expenseDate is required",
      });
    }
    if (!amountTotal) {
      return res.status(400).json({
        status: false,
        message: "amountTotal is required",
      });
    }
    if (!Array.isArray(expenseDetails) || expenseDetails.length === 0) {
      return res.status(400).json({
        status: false,
        message: "expenseDetails array is required and cannot be empty",
      });
    }

    // Validate each expense detail entry
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

    // Create expense master entry
    const expenseMaster = await ExpenseMaster.create({
      voucherNo,
      expenceDate: expenseDate,
      totalAmount: amountTotal,
      createdBy: userId,
      updatedBy: userId,
    });

    const expenseMasterId = expenseMaster.id;

    // Prepare expense details
    const formattedExpenseDetails = expenseDetails.map((expense) => ({
      ExpenseMasterId: expenseMasterId,
      name: " ", // You may need to update this field if it has a specific purpose
      projectId: expense.projectId,
      ExpenseHeadId: expense.ExpenseHeadId,
      naration: expense.naration,
      amount: parseFloat(expense.amount),
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

// exports.getAllExpenses = async (req, res) => {
//   try {
//     // Fetch all expense masters with their details
//     const expenses = await ExpenseMaster.findAll({
//       include: [
//         {
//           model: ExpenseDetail, // Include related ExpenseDetail entries
//           as: "details", // Alias for association
//         },
//       ],
//     });

//     // Check if any expenses exist
//     if (!expenses || expenses.length === 0) {
//       return res.status(404).json({
//         status: false,
//         message: "No expenses found",
//       });
//     }

//     return res.status(200).json({
//       status: true,
//       message: "Expenses retrieved successfully",
//       data: expenses,
//     });
//   } catch (error) {
//     console.error("Error while retrieving expenses:", error);
//     return res.status(500).json({
//       status: false,
//       message: "An error occurred while retrieving the expenses",
//       error: error.message,
//     });
//   }
// };

const { Op } = require("sequelize"); // Import Sequelize operators

exports.getAllExpenses = async (req, res) => {
  try {
    const { projectId, ExpenseHeadId, startDate, endDate } = req.query; // Extract filters from query parameters

    // Define filter conditions dynamically
    const expenseMasterWhereCondition = {};
    const expenseDetailWhereCondition = {};

    // Apply date range filter on ExpenseMaster
    if (startDate && endDate) {
      expenseMasterWhereCondition.expenceDate = {
        [Op.between]: [new Date(startDate), new Date(endDate)], // Filter expenses within the date range
      };
    } else if (startDate) {
      expenseMasterWhereCondition.expenceDate = {
        [Op.gte]: new Date(startDate), // Expenses from startDate onwards
      };
    } else if (endDate) {
      expenseMasterWhereCondition.expenceDate = {
        [Op.lte]: new Date(endDate), // Expenses up to endDate
      };
    }

    // Apply project-wise and expense-wise filters on ExpenseDetail
    if (projectId) {
      expenseDetailWhereCondition.projectId = projectId;
    }

    if (ExpenseHeadId) {
      expenseDetailWhereCondition.ExpenseHeadId = ExpenseHeadId;
    }

    // Fetch expenses with filters applied
    const expenses = await ExpenseMaster.findAll({
      where: Object.keys(expenseMasterWhereCondition).length
        ? expenseMasterWhereCondition
        : undefined, // Apply filters only if they exist
      include: [
        {
          model: ExpenseDetail,
          as: "details",
          where: Object.keys(expenseDetailWhereCondition).length
            ? expenseDetailWhereCondition
            : undefined, // Apply filters only if they exist
        },
      ],
    });

    // Check if any expenses exist
    if (!expenses || expenses.length === 0) {
      return res.status(404).json({
        status: false,
        message: "No expenses found",
      });
    }

    return res.status(200).json({
      status: true,
      message: "Expenses retrieved successfully",
      data: expenses,
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
    const expenseDetail = await ExpenseDetail.findOne({ where: { id } });
    const expenseMasterId = expenseDetail.ExpenseMasterId;
    if (!expenseDetail) {
      return res.status(200).json({
        status: false,
        message: "Expense detail not found",
      });
    }
    //find total form expenseMasterId
    const totalAmount = await ExpenseMaster.findOne({
      where: { id: expenseMasterId },
    });
    const total = totalAmount.totalAmount - expenseDetail.amount;
    //update total in expenseMaster
    if (total < 0) {
      await ExpenseMaster.update(
        { totalAmount: total },
        { where: { id: expenseMasterId } }
      );
    } else {
      await ExpenseMaster.destroy({ where: { id: expenseMasterId } });
    }

    await expenseDetail.destroy();

    return res.status(200).json({
      status: true,
      message: "Expense detail deleted successfully",
    });
  } catch (error) {
    res.status(500).json({
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
    const expenseMaster = await ExpenseMaster.findOne({
      where: { id: id },
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
      where: { ExpenseMasterId: expenseDetail.ExpenseMasterId },
    });
    const expenseMaster = await ExpenseMaster.findOne({
      where: { id: expenseDetail.ExpenseMasterId },
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
