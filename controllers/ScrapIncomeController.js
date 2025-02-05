const { Income, ScrapIncome, Project } = require("../models");

exports.createScrapIncome = async (req, res) => {
  const {
    projectId,

    amount,
    paymentMode,
    dateReceived,

    bankName,
    chequeNumber,
    chequeDate,
    buyerName,
  } = req.body;
  const userId = req.userId;
  const incomeType = "Scrap";
  if (!projectId) {
    return res
      .status(200)
      .json({ success: false, message: "Project is required" });
  }
  if (!amount) {
    return res
      .status(200)
      .json({ success: false, message: "Amount is required" });
  }
  if (!paymentMode) {
    return res
      .status(200)
      .json({ success: false, message: "Payment mode is required" });
  }
  if (!dateReceived) {
    return res
      .status(200)
      .json({ success: false, message: "Date received is required" });
  }

  try {
    const income = await Income.create({
      projectId,
      incomeType,
      amount,
      paymentMode,
      dateReceived,
      createdBy: userId,
      updatedBy: userId,
    });

    const Scrap = await ScrapIncome.create({
      incomeId: income.id,
      buyerName,
      bankName,
      chequeNumber,
      chequeDate,
      createdBy: userId,
      updatedBy: userId,
    });

    return res.status(200).json({
      success: true,
      data: { Scrap, income },
    });
  } catch (error) {
    console.error("Error details:", error); // Log the error
    return res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};
exports.getAllScrapIncomes = async (req, res) => {
  try {
    const incomes = await Income.findAll({
      where: {
        incomeType: "Scrap",
      },
      include: [
        {
          model: Project,
          attributes: ["id", "projectName"],
        },
        {
          model: ScrapIncome,
          attributes: [
            "incomeId",
            "buyerName",
            "bankName",
            "chequeNumber",
            "chequeDate",
          ],
        },
      ],
    });

    return res.status(200).json({
      success: true,
      data: incomes,
    });
  } catch (error) {
    console.error("Error details:", error); // Log the error
    return res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};
