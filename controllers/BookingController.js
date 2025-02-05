const {
  BookingMaster,
  CustomerMaster,
  BookingCustomer,
  ProjectStage,
  BookingPaymentTerms,
  BookingPaymentTermsDetail,
} = require("../models");

exports.storeBooking = async (req, res) => {
  try {
    const data = req.body;
    const userId = req.userId;

    const requiredFields = [
      "projectId",
      "projectUnitId",
      "brokerId",
      "saleDeedAmount",
      "extraWorkAmount",
      "otherWorkAmount",
      "bookingDate",
      "customerNames",
      "address",
      "mobileNumber",
      "selectPlan",
      "frequency",
      "defaultDate",
      "isByBuilder",
      "installmentDetails",
    ];

    for (const field of requiredFields) {
      if (data[field] === undefined || data[field] === null) {
        return res.status(200).json({
          status: false,
          message: `${field} is required`,
        });
      }
    }

    const booking = await BookingMaster.create({
      projectId: data.projectId,
      projectUnitId: data.projectUnitId,
      brokerId: "1",
      saleDeedAmount: data.saleDeedAmount,
      extraWorkAmount: data.extraWorkAmount,
      otherWorkAmount: data.otherWorkAmount,
      bookingDate: data.bookingDate,
      createdBy: userId,
      updatedBy: userId,
    });

    const customerData = data.customerNames.map((name, index) => ({
      customerName: name,
      address: data.address,
      mobileNumber: data.mobileNumber[index] || "",
      type: index === 0 ? "Primary" : "Others",
      createdBy: userId,
      updatedBy: userId,
    }));

    const customers = await CustomerMaster.bulkCreate(customerData);

    const bookingCustomers = customers.map((customer) => ({
      bookingId: booking.id,
      customerId: customer.id,
      createdBy: userId,
      updatedBy: userId,
    }));

    await BookingCustomer.bulkCreate(bookingCustomers);

    const paymentTerms = await BookingPaymentTerms.create({
      bookingId: booking.id,
      selectPlan: data.selectPlan,
      frequency: data.frequency,
      defaultDate: data.defaultDate,
      loanStatus: data.loanStatus,
      loanBankName: data.loanBankName,
      loanAgentName: data.loanAgentName,
      isByBuilder: data.isByBuilder,
      createdBy: userId,
      updatedBy: userId,
    });

    const stageData = await ProjectStage.findAll({
      where: { projectId: data.projectId },
    });

    if (!stageData || stageData.length === 0) {
      return res.status(400).json({
        status: false,
        message: "No stages found for the given project",
      });
    }

    const paymentTermsDetails = stageData.map((stage) => {
      const stagePercentage = stage.projectStagePer;
      const saleDeedAmount = data.saleDeedAmount;

      if (isNaN(stagePercentage) || isNaN(saleDeedAmount)) {
        throw new Error(
          `Invalid values: stagePercentage (${stagePercentage}), saleDeedAmount (${saleDeedAmount})`
        );
      }

      const stageAmount = (stagePercentage / 100) * saleDeedAmount;

      if (isNaN(stage.id) || isNaN(stageAmount)) {
        throw new Error(
          `Invalid stageId or stageAmount for stage: ${stage.id}`
        );
      }

      return {
        BookingPaymentTermsId: paymentTerms.id,
        installmentId: stage.id,
        type: stage.stageName,
        installmentAmount: stageAmount,
        installmentDueDate: stage.stageDueDate,
        createdBy: userId,
        updatedBy: userId,
      };
    });

    if (paymentTermsDetails.length === 0) {
      return res.status(400).json({
        status: false,
        message: "No valid stages available for payment terms",
      });
    }

    await BookingPaymentTermsDetail.bulkCreate(paymentTermsDetails);

    return res.status(200).json({
      status: true,
      message: "Booking created successfully",
      data: {
        booking,
        customers,
        paymentTerms,
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

exports.getBookings = async (req, res) => {
  try {
    let { page = 1, limit = 10 } = req.query;

    // Parse the page and limit as integers
    page = parseInt(page);
    limit = parseInt(limit);

    // Ensure page and limit are valid numbers
    if (page < 1) page = 1;
    if (limit < 1) limit = 10;

    // Calculate the offset based on the page
    const offset = (page - 1) * limit;

    // Fetch paginated booking details
    const { count, rows: bookings } = await BookingMaster.findAndCountAll({
      include: [
        {
          model: BookingCustomer,
          required: false,
        },
        {
          model: BookingPaymentTerms,
          where: { isDeleted: false },
          required: false,
          include: [
            {
              model: BookingPaymentTermsDetail,
              required: false,
            },
          ],
        },
      ],
      limit,
      offset,
      order: [["createdAt", "DESC"]],
    });

    // Calculate the total number of pages
    const totalPages = Math.ceil(count / limit);

    // Send the paginated response
    res.status(200).json({
      totalRecords: count,
      totalPages,
      currentPage: page,
      hasNextPage: page < totalPages,
      hasPrevPage: page > 1,
      bookings,
    });
  } catch (error) {
    console.error("Error fetching booking list:", error);
    res.status(500).json({ message: "Internal server error" });
  }
};

exports.getProjectWiseStages = async (req, res) => {
  try {
    const projectId = req.params.projectId;
    const stages = await ProjectStage.findAll({
      where: { projectId },
    });
    return res.status(200).json({
      status: true,
      message: "Project stages fetched successfully",
      data: stages,
    });
  } catch (error) {
    console.error("Error while fetching project stages:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while fetching project stages",
      error: error.message,
    });
  }
};

exports.getBookingAndPaymentHistory = async (req, res) => {
  try {
    const { customerName } = req.body;

    const findCustomerDetails = await CustomerMaster.findAll({
      where: {
        customerName,
      },
    });

    if (!findCustomerDetails) {
      return res.status(404).json({ message: "Customer not found" });
    }
    return res.json({
      status: true,
      message: "Customer fetched successfully",
      data: findCustomerDetails,
    });

    const booking = await BookingMaster.findOne({
      where: {
        customerId: findCustomerDetails.id,
      },
      include: [
        {
          model: BookingPaymentTerms,
          required: false,
          include: [
            {
              model: BookingPaymentTermsDetail,
              required: false,
            },
          ],
        },
      ],
      order: [
        ["createdAt", "DESC"],
        ["bookingPaymentTerms.createdAt", "DESC"],
        ["bookingPaymentTermsDetails.createdAt", "DESC"],
      ],
    });

    if (!booking) {
      return res.status(404).json({ message: "Booking not found" });
    }

    return res.json({
      status: true,
      message: "Booking and payment history fetched successfully",
      data: {
        customer: findCustomerDetails,
        booking,
      },
    });
  } catch (error) {
    console.error("Error while fetching booking and payment history:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while fetching booking and payment history",
      error: error.message,
    });
  }
};
