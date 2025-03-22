const { IncomeBooking, IncomeBookingDetail } = require("../models");

exports.getIncomeBooking = async (req, res) => {
  try {
    const incomeBooking = await IncomeBooking.findAll({
      include: [
        {
          model: IncomeBookingDetail,
          as: "bookingDetails",
        },
      ],
    });
    return res.status(200).json({
      status: true,
      message: "Income booking fetched successfully",
      data: incomeBooking,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: err.message,
    });
  }
};

exports.addIncomeBooking = async (req, res) => {
  try {
    const {
      amount,
      incomeDate,
      bookingId,
      incomeType,
      depositDate,
      receiptNo,
      receiptName,
      bankName,
      chequeNo,
      chequeDate,
      receiptUrl,
      term_id,
      percentage,
    } = req.body;

    const userId = req.userId;
    // Ensure required fields are provided
    if (
      !amount ||
      !incomeDate ||
      !bookingId ||
      !incomeType ||
      !Array.isArray(term_id) || // Check if term_id is an array
      !Array.isArray(percentage) || // Check if percentage is an array
      term_id.length !== percentage.length // Ensure both arrays have the same length
    ) {
      return res.status(400).json({
        status: false,
        message: "Missing or invalid required fields",
      });
    }

    // Create the IncomeBooking record
    const newIncomeBooking = await IncomeBooking.create({
      amount,
      incomeDate,
      bookingId,
      incomeType,
      depositDate,
      receiptNo,
      receiptName,
      bankName,
      chequeNo,
      chequeDate,
      receiptUrl,
      createdBy: userId,
      updatedBy: userId,
    });

    // Create multiple IncomeBookingDetail records
    const incomeBookingDetails = term_id.map((term, index) => ({
      incomeBookingId: newIncomeBooking.id,
      term_id: term,
      percentage: percentage[index],
      createdBy: userId,
      updatedBy: userId,
    }));

    await IncomeBookingDetail.bulkCreate(incomeBookingDetails);

    return res.status(200).json({
      status: true,
      message: "Income booking added successfully",
      data: newIncomeBooking,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: err.message,
    });
  }
};
