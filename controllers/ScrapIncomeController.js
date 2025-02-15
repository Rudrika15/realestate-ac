const e = require("cors");
const sequelize = require("../config/database");
const {
  Income,
  ScrapIncome,
  Project,
  IncomeHead,
  BookingMaster,
} = require("../models");
const InstallmentIncome = require("../models/IncomeInstallment");
const { QueryTypes } = require("sequelize");

exports.createIncomeHead = async (req, res) => {
  try {
    const incomeHeadName = req.body.incomeHeadName;
    if (!incomeHeadName) {
      return res.status(200).json({
        success: false,
        message: "Income head name is required",
      });
    }
    const existIncomeHead = await IncomeHead.findOne({
      where: {
        incomeHeadName: incomeHeadName,
      },
    });

    if (existIncomeHead) {
      return res.status(200).json({
        status: false,
        message: "Income head already exists",
      });
    }
    const userId = req.userId;
    const incomeHead = await IncomeHead.create({
      incomeHeadName: incomeHeadName,
      createdBy: userId,
      updatedBy: userId,
    });
    return res.status(200).json({
      success: true,
      message: "Income head created successfully",
      data: incomeHead,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "An error occurred while processing your request",
      error: error.message,
    });
  }
};
exports.getIncomeHead = async (req, res) => {
  try {
    const incomeHead = await IncomeHead.findAll();

    return res.status(200).json({
      success: true,
      message: "Income head fetched successfully",
      data: incomeHead,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "An error occurred while processing your request",
      error: error.message,
    });
  }
};
exports.createScrapIncome = async (req, res) => {
  const { incomes } = req.body;
  const userId = req.userId;

  console.log("Received payload:", req.body);
  console.log("Extracted incomes:", incomes);

  if (!incomes || !Array.isArray(incomes) || incomes.length === 0) {
    return res
      .status(400)
      .json({ success: false, message: "Incomes array is required" });
  }

  try {
    const createdIncomes = [];
    const createdScrapIncomes = [];

    for (const incomeData of incomes) {
      console.log("Processing income data:", incomeData);

      const {
        projectId,
        incomeType,
        amount,
        paymentMode,
        dateReceived,
        incomeHeadId,
        PartnerId,
        buyerName,
        narration,
        chequeDate,
        bankName,
        chequeNumber,
      } = incomeData;

      if (!projectId) {
        console.error("Error: Project ID missing in", incomeData);
        return res
          .status(400)
          .json({ success: false, message: "Project is required" });
      }
      if (!amount) {
        return res
          .status(400)
          .json({ success: false, message: "Amount is required" });
      }
      if (!paymentMode) {
        return res
          .status(400)
          .json({ success: false, message: "Payment mode is required" });
      }
      if (!dateReceived) {
        return res
          .status(400)
          .json({ success: false, message: "Date received is required" });
      }

      // Validate cheque fields only if payment mode is cheque
      if (paymentMode.toLowerCase() === "cheque") {
        if (!chequeDate || !bankName || !chequeNumber) {
          return res.status(400).json({
            success: false,
            message:
              "Cheque date, bank name, and cheque number are required for cheque payments",
          });
        }
      }

      const income = await Income.create({
        projectId,
        incomeType: "Others",
        amount,
        paymentMode,
        dateReceived,
        incomeHeadId,
        PartnerId,
        createdBy: userId,
        updatedBy: userId,
      });

      createdIncomes.push(income);

      const scrapIncome = await ScrapIncome.create({
        incomeId: income.id,
        buyerName,
        narration: narration,
        chequeDate: paymentMode.toLowerCase() === "cheque" ? chequeDate : null,
        bankName: paymentMode.toLowerCase() === "cheque" ? bankName : null,
        chequeNumber:
          paymentMode.toLowerCase() === "cheque" ? chequeNumber : null,
        createdBy: userId,
        updatedBy: userId,
      });

      createdScrapIncomes.push(scrapIncome);
    }

    return res.status(200).json({
      success: true,
      data: {
        incomes: createdIncomes,
        scrapIncomes: createdScrapIncomes,
      },
    });
  } catch (error) {
    console.error("Error details:", error);
    return res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

exports.getAllScrapIncomes = async (req, res) => {
  try {
    const { incomeHeadId, startDate, endDate, paymentMode } = req.query;

    const whereCondition = {
      incomeType: "Others",
    };

    // Filter by Income Head
    if (incomeHeadId) {
      whereCondition.incomeHeadId = incomeHeadId;
    }

    // Filter by Date Range
    if (startDate && endDate) {
      whereCondition.createdAt = {
        [Op.between]: [new Date(startDate), new Date(endDate)],
      };
    }

    // Filter by Payment Mode (cash or cheque)
    if (paymentMode) {
      whereCondition.paymentMode = paymentMode; // Ensure your model has a paymentMode field
    }

    const scrapIncomes = await Income.findAll({
      where: whereCondition,
      include: [
        {
          model: Project,
          attributes: ["id", "projectName"],
        },
        {
          model: IncomeHead,
          as: "IncomeHead",
          attributes: ["id", "incomeHeadName"],
        },
        {
          model: ScrapIncome,
          attributes: [
            "id",
            "buyerName",
            "narration",
            "chequeDate",
            "bankName",
            "chequeNumber",
          ],
        },
      ],
    });

    return res.status(200).json({
      success: true,
      data: scrapIncomes,
    });
  } catch (error) {
    console.error("Error details:", error);
    return res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

exports.addIncome = async (req, res) => {
  try {
    const data = req.body;

    if (!data.type) {
      return res.status(200).json({
        success: false,
        message: "Type is required",
      });
    }

    if (!data.depositDate) {
      return res.status(200).json({
        success: false,
        message: "Deposit Date is required",
      });
    }
    if (!data.amount) {
      return res.status(200).json({
        success: false,
        message: "Amount is required",
      });
    }
    if (!data.receiptNo) {
      return res.status(200).json({
        success: false,
        message: "Receipt No is required",
      });
    }
    if (!data.receiptName) {
      return res.status(200).json({
        success: false,
        message: "Receipt Name is required",
      });
    }
    if (!data.projectUnitId) {
      return res.status(200).json({
        success: false,
        message: "Project Unit Id is required",
      });
    }

    if (data.type == "Installment") {
      if (!data.bankName) {
        return res.status(200).json({
          success: false,
          message: "Bank Name is required",
        });
      }
      if (!data.chequeNumber) {
        return res.status(200).json({
          success: false,
          message: "Cheque Number is required",
        });
      }
      if (!data.chequeDate) {
        return res.status(200).json({
          success: false,
          message: "Cheque Date is required",
        });
      }
    }

    const findBooking = await BookingMaster.findOne({
      where: {
        projectUnitId: data.projectUnitId,
      },
    });

    const bookingId = findBooking.id;

    const userId = req.userId;
    const income = await Income.create({
      projectId: data.projectId,
      incomeType: "Installment",
      amount: data.amount,
      depositDate: data.depositDate,
      dateReceived: data.depositDate,
      createdBy: userId,
      updatedBy: userId,
    });

    const installment = await InstallmentIncome.create({
      incomeId: income.id,
      bookingId: bookingId,
      receiptNo: data.receiptNo,
      receiptName: data.receiptName,
      bankName: data.bankName,
      chequeNumber: data.chequeNumber,
      chequeDate: data.chequeDate,
      createdBy: userId,
      updatedBy: userId,
    });
    return res.status(200).json({
      success: true,
      message: "Income created successfully",
      data: {
        installment,
        income,
      },
    });
  } catch (error) {
    console.error("Error details:", error);
    return res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

exports.getOtherSingleIncome = async (req, res) => {
  try {
    const id = req.params.id;
    const income = await Income.findOne({
      where: { id },
      include: [
        {
          model: Project,
          attributes: ["id", "projectName"],
        },
        {
          model: IncomeHead,
          as: "IncomeHead",
        },
        {
          model: ScrapIncome,
          attributes: [
            "id",
            "buyerName",
            "narration",
            "chequeDate",
            "bankName",
            "chequeNumber",
          ],
        },
        {
          model: ScrapIncome,
        },
      ],
    });

    if (!income) {
      return res.status(404).json({ message: "Income not found" });
    }

    res.status(200).json({ data: income });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteScrapIncome = async (req, res) => {
  const transaction = await sequelize.transaction(); // Start a transaction
  try {
    const id = req.params.id;

    // Fetch Scrap Income
    const [scrapIncome] = await sequelize.query(
      "SELECT * FROM ScrapIncomes WHERE incomeId = :id LIMIT 1",
      {
        replacements: { id },
        type: QueryTypes.SELECT,
        transaction,
      }
    );

    if (!scrapIncome) {
      await transaction.rollback();
      return res
        .status(200)
        .json({ status: false, message: "Scrap Income not found" });
    }

    const IncomeId = scrapIncome.incomeId;

    // Delete income
    await sequelize.query("DELETE FROM Incomes WHERE id = :IncomeId", {
      replacements: { IncomeId },
      type: QueryTypes.DELETE,
      transaction,
    });

    // Delete scrap income
    await sequelize.query("DELETE FROM ScrapIncomes WHERE id = :id", {
      replacements: { id },
      type: QueryTypes.DELETE,
      transaction,
    });

    await transaction.commit(); // Commit transaction

    return res.status(200).json({
      status: true,
      data: IncomeId,
      message: "Scrap Income deleted successfully",
    });
  } catch (error) {
    await transaction.rollback(); // Rollback transaction on error
    res.status(500).json({ status: false, message: error.message });
  }
};

exports.updateScrapIncome = async (req, res) => {
  try {
    const id = req.params.id;
    const {
      buyerName,
      narration,
      chequeNumber,
      chequeDate,
      bankName,

      projectId,
      incomeHeadId,
      amount,
      paymentMode,
      dateReceived,
    } = req.body;
    if (!projectId) {
      return res.status(200).json({
        success: false,
        message: "Project is required",
      });
    }
    if (!incomeHeadId) {
      return res.status(200).json({
        success: false,
        message: "Income Head is required",
      });
    }
    if (!amount) {
      return res.status(200).json({
        success: false,
        message: "Amount is required",
      });
    }
    if (!paymentMode) {
      return res.status(200).json({
        success: false,
        message: "Payment Mode is required",
      });
    }
    if (!dateReceived) {
      return res.status(200).json({
        success: false,
        message: "Date Received is required",
      });
    }
    if (paymentMode == "Cheque") {
      if (!bankName) {
        return res.status(200).json({
          success: false,
          message: "Bank Name is required",
        });
      }
      if (!chequeNumber) {
        return res.status(200).json({
          success: false,
          message: "Cheque Number is required",
        });
      }
      if (!chequeDate) {
        return res.status(200).json({
          success: false,
          message: "Cheque Date is required",
        });
      }
    }
    if (!narration) {
      return res.status(200).json({
        success: false,
        message: "Narration is required",
      });
    }
    const userId = req.userId;
    const scrapIncome = await ScrapIncome.findOne({ where: { id } });

    if (!scrapIncome) {
      return res
        .status(404)
        .json({ success: false, message: "Scrap Income not found" });
    }

    const incomeId = scrapIncome.incomeId; // Get related Income ID

    // Update ScrapIncome
    await scrapIncome.update({
      buyerName,
      narration,
      chequeNumber,
      chequeDate,
      bankName,
      projectId,
      incomeHeadId,
      amount,
      paymentMode,
      dateReceived,
      updatedBy: userId,
    });

    // Find and Update Income
    const income = await Income.findOne({ where: { id: incomeId } });

    if (income) {
      await income.update({
        projectId,
        incomeType: "Others", // Corrected from "Others"
        amount,
        incomeHeadId,
        paymentMode,
        dateReceived,
        updatedBy: userId,
      });
    }

    return res.status(200).json({
      success: true,
      message: "Scrap Income updated successfully",
      data: {
        scrapIncome,
        income,
      },
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
