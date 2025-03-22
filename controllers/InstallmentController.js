const { Income } = require("../models");
const InstallmentIncome = require("../models/IncomeInstallment");

exports.createInstallment = async (req, res) => {
  const {
    projectId,
    amount,
    paymentMode,
    dateReceived,
    bookingId,
    chequeNumber,
    chequeDate,
    bankName,
    receiptNo,
    receiptDate,
    receiptName,
    loanId,
    verificationStatus,
    verificationDate,
    verificationBy,
    receiptURL,
    paymentType,
    amountType,
  } = req.body;

  const incomeType = "Installment";
  const userId = req.userId;

  // Validation checks
  if (!projectId) {
    return res
      .status(200)
      .json({ status: false, message: "Project is required" });
  }
  if (!amount) {
    return res
      .status(200)
      .json({ status: false, message: "Amount is required" });
  }
  if (!paymentMode) {
    return res
      .status(200)
      .json({ status: false, message: "Payment mode is required" });
  }
  if (!dateReceived) {
    return res
      .status(200)
      .json({ status: false, message: "Date received is required" });
  }
  if (!bookingId) {
    return res
      .status(200)
      .json({ status: false, message: "Booking is required" });
  }
  if (!receiptNo) {
    return res
      .status(200)
      .json({ status: false, message: "Receipt No is required" });
  }
  if (!receiptDate) {
    return res
      .status(200)
      .json({ status: false, message: "Receipt Date is required" });
  }
  if (!bankName) {
    return res
      .status(200)
      .json({ status: false, message: "Bank Name is required" });
  }
  if (!paymentType) {
    return res
      .status(200)
      .json({ status: false, message: "Payment Type is required" });
  }
  if (!amountType) {
    return res
      .status(200)
      .json({ status: false, message: "Amount Type is required" });
  }

  try {
    // Create Income entry
    const income = await Income.create({
      projectId,
      amount,
      paymentMode,
      dateReceived,
      incomeType,
      createdBy: userId,
      updatedBy: userId,
      paymentType: paymentType, // Default if not provided
      amountType: amountType, // Default if not provided
      bookingId,
    });

    // Create Installment Income entry
    const installment = await InstallmentIncome.create({
      incomeId: income.id,
      bookingId,
      installmentId: income.id,
      chequeNumber,
      chequeDate,
      bankName,
      receiptNo,
      receiptName,
      receiptDate,
      loanId,
      verificationStatus: verificationStatus || "Pending", // Default to 'Pending' if not provided
      verificationDate,
      verificationBy,
      receiptURL,
      isDeleted: false,
      isLocked: false,
      createdBy: userId,
      updatedBy: userId,
    });

    return res.status(200).json({
      status: true,
      message: "Installment created successfully",
      data: installment,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message });
  }
};

// exports.getInstallments = async (req, res) => {
//   try {
//     const { installmentId } = req.params; // Get installment ID from request params

//     let query = {
//       include: [
//         {
//           model: Income,
//           attributes: [
//             "id",
//             "projectId",
//             "amount",
//             "paymentMode",
//             "dateReceived",
//             "incomeType",
//           ],
//         },
//       ],
//     };

//     if (installmentId) {
//       query.where = { id: installmentId };
//     }

//     const installments = await InstallmentIncome.findAll(query);

//     if (!installments || installments.length === 0) {
//       return res
//         .status(200)
//         .json({ status: false, message: "No installment found" });
//     }

//     return res.status(200).json({
//       status: true,
//       message: "Installment details retrieved successfully",
//       data: installments,
//     });
//   } catch (error) {
//     console.error(error);
//     return res.status(500).json({ status: false, message: error.message });
//   }
// };
exports.getInstallments = async (req, res) => {
  try {
    const { installmentId } = req.params; // Get installment ID from request params
    const { page = 1, limit = 10 } = req.query; // Get pagination parameters from query params

    const offset = (page - 1) * limit; // Calculate offset

    let query = {
      include: [
        {
          model: Income,
          attributes: [
            "id",
            "projectId",
            "amount",
            "paymentMode",
            "dateReceived",
            "incomeType",
          ],
        },
      ],
      limit: parseInt(limit),
      offset: parseInt(offset),
    };

    if (installmentId) {
      query.where = { id: installmentId };
    }

    const { count, rows: installments } =
      await InstallmentIncome.findAndCountAll(query);

    if (!installments || installments.length === 0) {
      return res
        .status(200)
        .json({ status: false, message: "No installment found" });
    }

    return res.status(200).json({
      status: true,
      message: "Installment details retrieved successfully",
      data: installments,
      pagination: {
        totalRecords: count,
        currentPage: parseInt(page),
        totalPages: Math.ceil(count / limit),
        pageSize: parseInt(limit),
      },
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ status: false, message: error.message });
  }
};

exports.getInstallmentById = async (req, res) => {
  try {
    const installmentId = req.params.id;
    const installment = await InstallmentIncome.findOne({
      where: { id: installmentId },
      include: [
        {
          model: Income,
          attributes: [
            "id",
            "projectId",
            "amount",
            "paymentMode",
            "dateReceived",
            "incomeType",
          ],
        },
      ],
    });

    if (!installment) {
      return res
        .status(200)
        .json({ status: false, message: "Installment not found" });
    }

    return res.status(200).json({
      status: true,
      message: "Installment details retrieved successfully",
      data: installment,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ status: false, message: error.message });
  }
};
exports.deleteInstallment = async (req, res) => {
  try {
    const installmentId = req.params.id;
    const installment = await InstallmentIncome.findOne({
      where: { id: installmentId },
    });

    if (!installment) {
      return res
        .status(200)
        .json({ status: false, message: "Installment not found" });
    }
    const incomeId = installment.incomeId;
    await Income.destroy({ where: { id: incomeId } });

    await installment.destroy();

    return res.status(200).json({
      status: true,
      message: "Installment deleted successfully",
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ status: false, message: error.message });
  }
};
exports.updateInstallment = async (req, res) => {
  try {
    const installmentId = req.params.id;
    const installment = await InstallmentIncome.findOne({
      where: { id: installmentId },
    });

    if (!installment) {
      return res
        .status(200)
        .json({ status: false, message: "Installment not found" });
    }

    const updatedInstallment = await InstallmentIncome.update(req.body, {
      where: { id: installmentId },
    });

    return res.status(200).json({
      status: true,
      message: "Installment updated successfully",
      data: updatedInstallment,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ status: false, message: error.message });
  }
};
