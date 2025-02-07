const sequelize = require("../config/database");
const {
  Income,
  ScrapIncome,
  Project,
  IncomeHead,
  BookingMaster,
} = require("../models");
const InstallmentIncome = require("../models/IncomeInstallment");

exports.createIncomeHead = async (req, res) => {
  try {
    const incomeHeadName = req.body.incomeHeadName;
    if (!incomeHeadName) {
      return res.status(200).json({
        success: false,
        message: "Income head name is required",
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

  console.log("Received payload:", req.body); // Log full request body
  console.log("Extracted incomes:", incomes); // Log extracted incomes

  if (!incomes || !Array.isArray(incomes) || incomes.length === 0) {
    return res
      .status(400)
      .json({ success: false, message: "Incomes array is required" });
  }

  try {
    const createdIncomes = [];

    for (const incomeData of incomes) {
      console.log("Processing income data:", incomeData); // Log each income entry

      const {
        projectId,
        incomeType,
        amount,
        paymentMode,
        dateReceived,
        PartnerId,
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

      const income = await Income.create({
        projectId,
        incomeType,
        amount,
        paymentMode,
        dateReceived,
        PartnerId,
        createdBy: userId,
        updatedBy: userId,
      });

      createdIncomes.push(income);
    }

    return res.status(200).json({
      success: true,
      data: createdIncomes,
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
    const scrapIncomes = await sequelize.query(
      `SELECT s.*,ih.incomeHeadName,i.*,p.projectName FROM ScrapIncomes s, IncomeHeads ih ,Incomes i ,Projects p WHERE p.id =i.projectId and ih.id =s.incomeHeadId and s.incomeId =i.id;`,
      {
        type: sequelize.QueryTypes.SELECT,
      }
    );

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
