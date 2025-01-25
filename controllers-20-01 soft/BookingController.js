const { BookingMaster, CustomerMaster, BookingCustomer } = require("../models");

exports.storeBooking = async (req, res) => {
  try {
    const data = req.body;
    const userId = req.userId;

    const requiredFields = [
      "projectId",
      "projectUnitId",
      "brokerName",
      "saleDeedAmount",
      "extraWorkAmount",
      "otherWorkAmount",
      "bookingDate",
      "customerNames",
      "address",
      "mobileNumber",
    ];

    for (const field of requiredFields) {
      if (!data[field]) {
        return res.status(200).json({
          status: false,
          message: `${field} is required`,
        });
      }
    }

    const booking = await BookingMaster.create({
      projectId: data.projectId,
      projectUnitId: data.projectUnitId,
      brokerName: data.brokerName,
      saleDeedAmount: data.saleDeedAmount,
      extraWorkAmount: data.extraWorkAmount,
      otherWorkAmount: data.otherWorkAmount,
      bookingDate: data.bookingDate,
      createdBy: userId,
      updatedBy: userId,
    });

    const customerNames = data.customerNames
      .split(",")
      .map((name) => name.trim());
    const customerData = customerNames.map((name, index) => ({
      customerName: name,
      address: data.address,
      mobileNumber: data.mobileNumber,
      type: index === 0 ? "Primary" : "Others",
      createdBy: userId,
      updatedBy: userId,
    }));

    const customer = await CustomerMaster.bulkCreate(customerData);

    // add data into the booking customer table
    const bookingCustomer = customer.map((customer) => ({
      bookingId: booking.id,
      customerId: customer.id,
      createdBy: userId,
      updatedBy: userId,
    }));

    await BookingCustomer.bulkCreate(bookingCustomer);

    return res.status(200).json({
      status: true,
      message: "Booking created successfully",
      data: {
        booking,
        customer,
      },
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while processing your request",
      error: err.message,
    });
  }
};
