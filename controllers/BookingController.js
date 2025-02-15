const { Sequelize } = require("sequelize");
// const { Op, QueryTypes } = require("sequelize");
const {
  BookingMaster,
  CustomerMaster,
  BookingCustomer,
  ProjectStage,
  BookingPaymentTerms,
  BookingPaymentTermsDetail,
  ProjectUnit,
} = require("../models");

const { QueryTypes } = require("sequelize");
const sequelize = require("../config/database");

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
      // "customerName",
      "address",
      // "mobileNumber",
      "selectPlan",
      "frequency",
      // "defaultDate",
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

    const findStatusOfUnit = await ProjectUnit.findOne({
      where: { id: data.projectUnitId },
    });
    if (findStatusOfUnit.currerntStatus !== "Unsold") {
      return res.status(400).json({
        status: false,
        message: "Unit is not available for booking",
      });
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

    const customerData = data.customerNames.map((customer, index) => ({
      customerName: customer.customerName,
      address: data.address,
      mobileNumber: customer.mobileNumber || "",
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

    const updateUnitStatus = await ProjectUnit.update(
      {
        currerntStatus: "Sold",
      },
      {
        where: {
          id: data.projectUnitId,
        },
      }
    );

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
    const { customerName, projectName, unitNo } = req.query;

    let whereClause = ` WHERE c.type = 'Primary' `;

    if (customerName) {
      whereClause += ` AND c.customerName LIKE :customerName `;
    }
    if (projectName) {
      whereClause += ` AND p.projectName LIKE :projectName `;
    }
    if (unitNo) {
      whereClause += ` AND pu.unitNo LIKE :unitNo `;
    }

    const query = `
      SELECT 
        b.*, 
        p.projectName, 
        pu.unitNo, 
        c.id as customerId, 
        c.customerName, 
        c.address, 
        c.mobileNumber
      FROM BookingMasters b
      JOIN Projects p ON p.id = b.projectId
      JOIN ProjectUnits pu ON pu.id = b.projectUnitId
      JOIN BookingCustomers bc ON bc.bookingId = b.id
      JOIN CustomerMasters c ON c.id = bc.customerId
      ${whereClause}
    `;

    const bookings = await sequelize.query(query, {
      type: QueryTypes.SELECT,
      replacements: {
        customerName: customerName ? `%${customerName}%` : null,
        projectName: projectName ? `%${projectName}%` : null,
        unitNo: unitNo ? `%${unitNo}%` : null,
      },
    });

    return res.status(200).json({
      status: true,
      message: "Bookings fetched successfully",
      data: bookings,
    });
  } catch (error) {
    console.error("Error fetching booking list:", error);
    res.status(500).json({
      status: false,
      message: "Internal server error",
      error: error.message,
    });
  }
};

exports.getProjectWiseStages = async (req, res) => {
  try {
    const { projectId } = req.params;
    const { projectWingId } = req.params;

    const query = `
      SELECT ps.projectStageName,ps.projectStagePer, p.*
      FROM ProjectStages ps
      INNER JOIN ProjectStageTransactions p ON p.projectStageId = ps.id
      WHERE ps.projectId = :projectId AND p.projectWingId = :projectWingId
    `;

    const stages = await sequelize.query(query, {
      replacements: { projectId, projectWingId },
      type: QueryTypes.SELECT,
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
    const { customerName, mobileNumber, unitNo } = req.query; // Using query parameters

    if (!customerName && !mobileNumber && !unitNo) {
      return res.status(400).json({
        status: false,
        message: "At least one of customerName, mobileNumber, or unitNo is required",
      });
    }

    const whereClause = {};

    if (customerName) {
      whereClause.customerName = { [Sequelize.Op.eq]: customerName }; // Exact match
    }

    if (mobileNumber) {
      whereClause.mobileNumber = { [Sequelize.Op.eq]: mobileNumber }; // Exact match
    }

    const findCustomerDetails = await CustomerMaster.findOne({ where: whereClause });

    if (!findCustomerDetails) {
      return res.status(404).json({
        status: false,
        message: "Customer not found",
      });
    }

    const findCustomer = await BookingCustomer.findOne({
      where: { customerId: findCustomerDetails.id },
      include: [
        {
          model: CustomerMaster,
          as: "customer",
          attributes: ["id", "customerName", "mobileNumber"],
        },
      ],
    });

    if (!findCustomer) {
      return res.status(404).json({
        status: false,
        message: "Booking not found for this customer",
      });
    }

    const bookingWhereClause = { id: findCustomer.bookingId };

    const includeClause = [
      {
        model: BookingPaymentTerms,
        as: "paymentTerms",
        where: { isDeleted: false },
        required: false,
        include: [
          {
            model: BookingPaymentTermsDetail,
            as: "paymentDetails",
            required: false,
          },
        ],
      },
      {
        model: BookingCustomer,
        as: "customers",
        include: [
          {
            model: CustomerMaster,
            as: "customer",
            attributes: ["id", "customerName", "mobileNumber"],
          },
        ],
      },
    ];

    // If unitNo is provided, filter bookings where the related ProjectUnit has the given unitNo
    if (unitNo) {
      includeClause.push({
        model: ProjectUnit, // Assuming this is the table containing unitNo
        as: "projectUnit",
        where: { unitNo: { [Sequelize.Op.eq]: unitNo } }, // Exact match for unit number
        required: true, // Ensures only matching unit numbers are returned
      });
    }

    const findBookingDetails = await BookingMaster.findOne({
      where: bookingWhereClause,
      include: includeClause,
    });

    if (!findBookingDetails) {
      return res.status(404).json({
        status: false,
        message: "No booking found with the given unit number",
      });
    }

    return res.status(200).json({
      status: true,
      message: "Booking and payment history fetched successfully",
      data: {
        customer: findCustomerDetails,
        bookingDetails: findBookingDetails,
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

