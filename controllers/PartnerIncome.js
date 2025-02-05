const { PartnerIncome, Income, Partner, Project } = require("../models");

exports.createPartnerIncome = async (req, res) => {
  const {
    projectId,

    amount,
    paymentMode,
    dateReceived,
    PartnerId,
    bankName,
    chequeNumber,
    chequeDate,
  } = req.body;
  const incomeType = "Partner";
  const userId = req.userId;
  if (!PartnerId) {
    return res
      .status(200)
      .json({ success: false, message: "Partner is required" });
  }
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
      .json({ success: false, message: "Payment Mode is required" });
  }
  if (!dateReceived) {
    return res
      .status(200)
      .json({ success: false, message: "Date Received is required" });
  }
  try {
    // Creating the income record
    const income = await Income.create({
      projectId,
      incomeType,
      amount,
      paymentMode,
      dateReceived,
      createdBy: userId,
      updatedBy: userId,
    });

    // Creating the partner income record
    const partnerIncome = await PartnerIncome.create({
      incomeId: income.id,
      partnerId: PartnerId,
      bankName,
      chequeNumber,
      chequeDate,
      createdBy: userId,
      updatedBy: userId,
    });

    res.status(200).json({
      success: true,
      message: "Income created successfully",
      data: income,
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Get All Partner Incomes
exports.getAllPartnerIncomes = async (req, res) => {
  try {
    const incomes = await Income.findAll({
      where: {
        incomeType: "Partner",
      },
      include: [
        {
          model: Project,
          attributes: ["id", "projectName"],
        },
        {
          model: PartnerIncome,
          include: [
            {
              model: Partner,
              attributes: ["id", "partnerName"],
            },
          ],
          attributes: ["incomeId", "partnerId", "chequeNumber", "chequeDate"],
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
      message: "Failed to retrieve incomes",
      error: error.message, // Return the error message in the response
    });
  }
};
