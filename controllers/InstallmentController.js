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
  } = req.body;
  const incomeType = "Installment";
  const userId = req.userId;

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

  try {
    const income = await Income.create({
      projectId,
      amount,
      paymentMode,
      dateReceived,
      incomeType,
      createdBy: userId,
      updatedBy: userId,
    });
    const installment = await InstallmentIncome.create({
      incomeId: income.id,
      bookingId,
      chequeNumber,
      chequeDate,
      bankName,
      receiptNo,
      receiptDate,
      createdBy: userId,
      updatedBy: userId,
    });
    return res
      .status(200)
      .json({
        status: true,
        message: "Installment created successfully",
        data: installment,
      });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message });
  }
};
