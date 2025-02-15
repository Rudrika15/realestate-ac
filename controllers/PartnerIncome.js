const { PartnerIncome, Income, Partner, Project } = require("../models");
const { Op } = require("sequelize");
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
    const { partnerId, projectId, startDate, endDate } = req.query;

    // Build the where clause dynamically
    let whereCondition = {
      incomeType: "Partner",
    };

    if (projectId) {
      whereCondition.projectId = projectId;
    }

    if (startDate && endDate) {
      whereCondition.dateReceived = {
        [Op.between]: [new Date(startDate), new Date(endDate)],
      };
    }

    const incomes = await Income.findAll({
      where: whereCondition,
      include: [
        {
          model: Project,
          attributes: ["id", "projectName"],
        },
        {
          model: PartnerIncome,
          where: partnerId ? { partnerId } : undefined, // Filter partner-wise if provided
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
    console.error("Error details:", error);
    return res.status(500).json({
      success: false,
      message: "Failed to retrieve incomes",
      error: error.message,
    });
  }
};
exports.deletePartnerIncome = async (req, res) => {
  const id = req.params.id;

  try {
    const partnerIncome = await PartnerIncome.findOne({
      where: { id: id },
    });

    if (!partnerIncome) {
      return res.status(404).json({ message: "Income not found" });
    }
    const incomeId = partnerIncome.incomeId;
    await Income.destroy({ where: { id: incomeId } });

    await partnerIncome.destroy();
    res.status(200).json({ message: "Income deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
exports.getPartnerIncomeDetail = async (req, res) => {
  const id = req.params.id;

  try {
    const partnerIncome = await PartnerIncome.findOne({
      where: { id: id },
      include: [
        {
          model: Income,
          include: [
            {
              model: Project,
              attributes: ["id", "projectName"],
            },
          ],
        },
        {
          model: Partner,
          attributes: ["id", "partnerName"],
        },
      ],
    });

    if (!partnerIncome) {
      return res.status(404).json({ message: "Income not found" });
    }

    res.status(200).json({ data: partnerIncome });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updatePartnerIncome = async (req, res) => {
  const id = req.params.id;
  const {
    projectId,
    amount,
    paymentMode,
    dateReceived,
    partnerId,
    bankName,
    chequeNumber,
    chequeDate,
  } = req.body;
  const userId = req.userId;

  try {
    const partnerIncome = await PartnerIncome.findByPk(id, {
      include: [{ model: Income }],
    });
    if (!partnerIncome) {
      return res
        .status(200)
        .json({ success: false, message: "Income not found" });
    }

    const findProject = await Project.findOne({
      where: { id: projectId },
    });
    if (!findProject) {
      return res
        .status(200)
        .json({ success: false, message: "Project not found" });
    }

    const findPartner = await Partner.findOne({
      where: { id: partnerId },
    });
    if (!findPartner) {
      return res
        .status(200)
        .json({ success: false, message: "Partner not found" });
    }

    const dateFormatted = new Date(dateReceived);
    if (isNaN(dateFormatted.getTime())) {
      return res
        .status(400)
        .json({ success: false, message: "Invalid date format" });
    }

    await partnerIncome.update({
      partnerId: partnerId ?? partnerIncome.partnerId,
      bankName: bankName ?? partnerIncome.bankName,
      chequeNumber: chequeNumber ?? partnerIncome.chequeNumber,
      chequeDate: chequeDate ?? partnerIncome.chequeDate,
      updatedBy: userId,
    });

    if (partnerIncome.Income) {
      await partnerIncome.Income.update({
        projectId: projectId ?? partnerIncome.Income.projectId,
        amount: amount ?? partnerIncome.Income.amount,
        paymentMode: paymentMode ?? partnerIncome.Income.paymentMode,
        dateReceived: dateReceived ?? partnerIncome.Income.dateReceived,
        updatedBy: userId,
      });
    }

    res.status(200).json({
      success: true,
      message: "Income updated successfully",
      data: { partnerIncome, income: partnerIncome.Income },
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
