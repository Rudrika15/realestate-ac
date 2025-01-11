const express = require("express");
const router = express.Router();

const {
  createBroker,
  getBrokers,
  getBrokerById,
  deleteBroker,
  updateBroker,
} = require("../controllers/BrokerController");

router.post("/store-broker", createBroker);
router.get("/get-broker", getBrokers);
router.get("/get-broker-by-id/:id", getBrokerById);
router.delete("/delete-broker/:id", deleteBroker);
router.post("/update-broker/:id", updateBroker);

module.exports = router;
