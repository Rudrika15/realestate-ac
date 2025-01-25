const { User } = require("../models");
const Broker = require("../models/Broker");

exports.createBroker = async (req, res) => {
  try {
    const { brokerName, brokerAddress, brokerMobileNumber } = req.body;
    const userid = req.userId;

    if (!brokerName) {
      return res.status(200).json({
        status: false,
        message: "brokerName is required",
      });
    }

    if (!brokerAddress) {
      return res.status(200).json({
        status: false,
        message: "brokerAddress is required",
      });
    }

    if (!brokerMobileNumber) {
      return res.status(200).json({
        status: false,
        message: "brokerMobileNumber is required",
      });
    }

    const broker = await Broker.create({
      brokerName,
      brokerAddress,
      brokerMobileNumber,
      createdBy: userid,
      updatedBy: userid,
    });

    return res.status(201).json({
      status: true,
      message: "Broker added successfully",
      data: broker,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while adding the broker",
      error: err.message,
    });
  }
};
exports.getBrokers = async (req, res) => {
  try {
    const brokers = await Broker.findAll({
      include: [
        {
          model: User,
          as: "BrokercreatedBy",
          attributes: ["userName"],
        },
        {
          model: User,
          as: "BrokerupdatedBy",
          attributes: ["userName"],
        },
      ],
    });

    return res.json({
      status: true,
      message: "Brokers fetched successfully",
      data: brokers,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while fetching the brokers",
      error: err.message,
    });
  }
};
exports.getBrokerById = async (req, res) => {
  try {
    const { id } = req.params;
    const broker = await Broker.findOne({ where: { id } });
    if (!broker) {
      return res.status(404).json({ message: "Broker not found" });
    }
    return res.json({
      status: true,
      message: "Broker fetched successfully",
      data: broker,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while fetching the broker",
      error: err.message,
    });
  }
};
exports.updateBroker = async (req, res) => {
  try {
    const { id } = req.params;
    const { brokerName, brokerAddress, brokerMobileNumber } = req.body;
    const userid = req.userId;
    if (!brokerName) {
      return res.status(200).json({
        status: false,
        message: "brokerName is required",
      });
    }

    if (!brokerAddress) {
      return res.status(200).json({
        status: false,
        message: "brokerAddress is required",
      });
    }

    if (!brokerMobileNumber) {
      return res.status(200).json({
        status: false,
        message: "brokerMobileNumber is required",
      });
    }

    const broker = await Broker.findOne({ where: { id } });

    broker.brokerName = brokerName;
    broker.brokerAddress = brokerAddress;
    broker.brokerMobileNumber = brokerMobileNumber;
    broker.updatedBy = userid;
    await broker.save();

    return res.status(200).json({
      status: true,
      message: "Broker updated successfully",
      data: broker,
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while updating the broker",
      error: err.message,
    });
  }
};

exports.deleteBroker = async (req, res) => {
  try {
    const { id } = req.params;
    const broker = await Broker.findOne({ where: { id } });
    if (!broker) {
      return res.status(404).json({ message: "Broker not found" });
    }
    await broker.destroy();
    return res.json({
      status: true,
      message: "Broker deleted successfully",
    });
  } catch (err) {
    return res.status(500).json({
      status: false,
      message: "An error occurred while deleting the broker",
      error: err.message,
    });
  }
};
